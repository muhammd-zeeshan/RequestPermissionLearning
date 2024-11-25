//
//  CameraPermission.swift
//  AppPermission
//
//  Created by Muhammad Zeeshan on 21/10/2024.
//

import SwiftUI
import AVFoundation

struct CameraPermission: View {
    @State private var isCameraAuthorized: Bool = false
    
    var body: some View {
        VStack {
            if isCameraAuthorized {
                Text("Camera Access Granted")
                    .font(.headline)
                    .foregroundStyle(.green)
            } else {
                Text("Camera Access Denied")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
            
                Button("Request Camera Access") {
                    requestCameraAccess()
                }
            }
        }
        .onAppear {
            checkCameraAuthentication()
        }
    }
    
    func checkCameraAuthentication() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        isCameraAuthorized = (status == .authorized)
    }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                isCameraAuthorized = granted
            }
        }
    }
}

#Preview {
    CameraPermission()
}
