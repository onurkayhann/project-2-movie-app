//
//  LocationManager.swift
//  FaveAndRate
//
//  Created by Hampus Andersson on 2024-10-28.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func askPermission() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            print("Start updating location")
            break
        case .notDetermined, .denied:
            askPermission()
            print("Ask permission")
            break
        case .restricted:
            print("Not allowed to use location")
            break
        default:
            print("erro")
            break
        }
    }
}
