//
//  ContactPermissionAccessView.swift
//  AppPermission
//
//  Created by Muhammad Zeeshan on 21/10/2024.
//

import SwiftUI
import Contacts

struct ContactsPermissionView: View {
    @StateObject private var viewModel = ContactsViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.permissionMessage) // Show the current permission status
                .padding()
                .multilineTextAlignment(.center)

            if viewModel.contactsPermissionManager.permissionStatus == .denied {
                Button("Go to Settings") {
                    viewModel.openSettings() // Open settings if permission was denied
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Request Contacts Access") {
                    viewModel.requestAccess() // Request access if not already granted
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}


#Preview {
    ContactsPermissionView()
}
