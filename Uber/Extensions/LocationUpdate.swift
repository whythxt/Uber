//
//  LocationUpdate.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import CoreLocation
import Foundation

extension LocationProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        provider.stopUpdatingLocation()
    }
}
