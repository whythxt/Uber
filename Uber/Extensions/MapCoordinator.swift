//
//  MapCoordinator.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import Foundation
import MapKit

extension MapViewRepresantable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: MapViewRepresantable
        var location: CLLocationCoordinate2D?
        var current: MKCoordinateRegion?

        init(parent: MapViewRepresantable) {
            self.parent = parent
            super.init()
        }

        // MARK: - MapView

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            location = userLocation.coordinate

            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
            ),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )

            current = region
            parent.map.setRegion(region, animated: true)
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let line = MKPolylineRenderer(overlay: overlay)
            line.strokeColor = .black
            line.lineWidth = 5

            return line
        }

        // MARK: - Annotation

        func addAnnotation(with coordinate: CLLocationCoordinate2D) {
            parent.map.removeAnnotations(parent.map.annotations)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate

            parent.map.addAnnotation(annotation)
            parent.map.selectAnnotation(annotation, animated: true)
        }

        // MARK: - Route Generation

        private func getDestination(
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
                completion(route)
            }
        }

        func getDirections(with destination: CLLocationCoordinate2D) {
            guard let location else { return }

            getDestination(from: location, to: destination) { route in
                self.parent.map.addOverlay(route.polyline)

                let rect = self.parent.map.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(
                    top: 64,
                    left: 32,
                    bottom: 500,
                    right: 32)
                )

                self.parent.map.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }

        func clear() {
            parent.map.removeAnnotations(parent.map.annotations)
            parent.map.removeOverlays(parent.map.overlays)

            if let current {
                parent.map.setRegion(current, animated: true)
            }
        }
    }
}
