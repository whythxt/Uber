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
    let provider = LocationProvider.shared

    @EnvironmentObject var vm: SearchViewModel

    @Binding var state: MapState

    func makeUIView(context: Context) -> some UIView {
        map.delegate = context.coordinator
        map.isRotateEnabled = false
        map.showsUserLocation = true
        map.userTrackingMode = .follow

        return map
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch state {
            case .idle:
                context.coordinator.clear()
                break
            case .search:
                break
            case .selected:
                if let coordinate = vm.selected?.coordinate {
                    context.coordinator.addAnnotation(with: coordinate)
                    context.coordinator.getDirections(with: coordinate)
                }
                break
            case .generated:
                break
        }
    }

    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}
