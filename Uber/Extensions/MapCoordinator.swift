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

        init(parent: MapViewRepresantable) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
            ),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )

            parent.map.setRegion(region, animated: true)
        }
    }
}
