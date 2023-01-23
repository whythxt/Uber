//
//  SearchViewModel.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import MapKit
import Foundation

class SearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selected: Location?

    @Published var pickup: String?
    @Published var dropoff: String?

    private let completer = MKLocalSearchCompleter()

    var location: CLLocationCoordinate2D? 

    var query = "" {
        didSet {
            completer.queryFragment = query
        }
    }

    override init() {
        super.init()
        completer.delegate = self
        completer.queryFragment = query
    }

    // MARK: - Search Handlers

    func select(_ location: MKLocalSearchCompletion) {
        search(for: location) { response, error in
            guard let item = response?.mapItems.first else { return }

            let coordinate = item.placemark.coordinate
            self.selected = Location(title: location.title, coordinate: coordinate)
        }
    }

    private func search(for local: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = local.title.appending(local.subtitle)

        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completion)
    }

    // MARK: - Trip Price

    func getPrice(for ride: RideType) -> Double {
        guard let cord = selected?.coordinate else { return 0 }
        guard let loc = location else { return 0 }

        let user = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
        let destination = CLLocation(latitude: cord.latitude, longitude: cord.longitude)

        let distance = user.distance(from: destination)
        return ride.price(for: distance)
    }

    // MARK: - Trip Route

    func getDestination(
        from location: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D,
        completion: @escaping (MKRoute) -> Void
    ) {
        let loc = MKPlacemark(coordinate: location)
        let des = MKPlacemark(coordinate: destination)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: loc)
        request.destination = MKMapItem(placemark: des)

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }

            self.getTime(with: route.expectedTravelTime)
            completion(route)
        }
    }

    // MARK: - Trip Time

    func getTime(with expected: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"

        pickup = formatter.string(from: Date.now)
        dropoff = formatter.string(from: Date.now + expected)

    }
}
