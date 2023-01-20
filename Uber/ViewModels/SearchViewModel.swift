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
    @Published var coordinate: CLLocationCoordinate2D?

    private let completer = MKLocalSearchCompleter()

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

    func select(_ location: MKLocalSearchCompletion) {
        search(for: location) { response, error in
            guard let item = response?.mapItems.first else { return }

            let coordinate = item.placemark.coordinate
            self.coordinate = coordinate
        }
    }

    func search(for local: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = local.title.appending(local.subtitle)

        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completion)
    }
}
