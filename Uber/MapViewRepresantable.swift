//
//  MapViewRepresantable.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import MapKit
import SwiftUI

struct MapViewRepresantable: UIViewRepresentable {
    let map = MKMapView()
    let provider = LocationProvider()

    @EnvironmentObject var vm: SearchViewModel

    func makeUIView(context: Context) -> some UIView {
        map.delegate = context.coordinator
        map.isRotateEnabled = false
        map.showsUserLocation = true
        map.userTrackingMode = .follow

        return map
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = vm.coordinate {
            context.coordinator.addAnnotation(with: coordinate)
            context.coordinator.getDirections(with: coordinate)
        }
    }

    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}
