//
//  DeviceLocationService.swift
//  Baluchon
//
//  Created by Clément Garcia on 29/03/2022.
//

import Foundation
import CoreLocation

class CoreLocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        determineCurrentLocation()
        
        return locationManager.location?.coordinate
    }
}
