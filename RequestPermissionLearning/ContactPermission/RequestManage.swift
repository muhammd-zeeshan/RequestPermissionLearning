//
//  RequestManage.swift
//  AppPermission
//
//  Created by Muhammad Zeeshan on 21/10/2024.
//

import Foundation
import Combine
import Contacts
import UIKit

class ContactsPermissionManager: ObservableObject {
    @Published var permissionStatus: CNAuthorizationStatus = .notDetermined

    private let contactStore = CNContactStore()

    init() {
        // Get the current permission status when the model is initialized
        self.permissionStatus = CNContactStore.authorizationStatus(for: .contacts)
    }

    // Function to request contacts access
    func requestContactsAccess() {
        contactStore.requestAccess(for: .contacts) { [weak self] granted, error in
            DispatchQueue.main.async {
                if granted {
                    self?.permissionStatus = .authorized
                } else {
                    self?.permissionStatus = .denied
                }
            }
        }
    }
}


class ContactsViewModel: ObservableObject {
    @Published var contactsPermissionManager = ContactsPermissionManager()

    var permissionMessage: String {
        switch contactsPermissionManager.permissionStatus {
        case .authorized:
            return "Contacts access granted."
        case .denied:
            return "Contacts access denied. Please enable it in settings."
        case .restricted:
            return "Contacts access is restricted."
        case .notDetermined:
            return "Contacts access has not been requested yet."
        case .limited:
            return "Blank"
        @unknown default:
            return "Unknown permission status."
        }
    }

    func requestAccess() {
        contactsPermissionManager.requestContactsAccess()
    }

    func openSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
}
