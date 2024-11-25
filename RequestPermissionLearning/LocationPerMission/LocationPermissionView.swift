//
//  LocationPermissionView.swift
//  AppPermission
//
//  Created by Muhammad Zeeshan on 21/10/2024.
//

import SwiftUI

struct LocationPermissionView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if let status = locationManager.locationStatus {
                switch status {
                case .authorizedWhenInUse:
                    Text("Location access Granted")
                case .denied, .restricted:
                    Text("Location Access Denied")
                    Button("Request Access Location") {
                        locationManager.requestLocationAccess()
                    }
                case .notDetermined:
                    Text("Location Access Not Determined")
                    Button("Request Location Access") {
                        locationManager.requestLocationAccess()
                    }
                default:
                    Text("Default")
                }
            }
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
    }
}

#Preview {
    LocationPermissionView()
}
