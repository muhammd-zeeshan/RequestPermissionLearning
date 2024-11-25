//
//  LocationManager.swift
//  AppPermission
//
//  Created by Muhammad Zeeshan on 21/10/2024.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    private var locationmanager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationmanager.delegate = self
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        locationStatus = locationmanager.authorizationStatus
    }
    
    func requestLocationAccess() {
        locationmanager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
