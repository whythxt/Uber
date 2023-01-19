//
//  LocationProvider.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import CoreLocation
import Foundation

class LocationProvider: NSObject, ObservableObject {
    let provider = CLLocationManager()

    override init() {
        super.init()
        provider.delegate = self
        provider.desiredAccuracy = kCLLocationAccuracyBest
        provider.requestWhenInUseAuthorization()
        provider.startUpdatingLocation()
    }
}


