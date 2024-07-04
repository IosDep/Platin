//
//  AppNotfications.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 29/07/2022.
//

import Foundation

struct AppNotifications {
    static let didChangeAuthStatusNotification = NSNotification.Name("did-change-auth")
    static let removeEKYCReference = NSNotification.Name("Open-Walle-vc")
    static let didChangeSavedContactsNotification = NSNotification.Name("did-Change-saved-Contacts")
    static let didChangeEditContactsNotification = NSNotification.Name("did-Change-edit-Contacts")
    static let didReceivePaymentNotification = NSNotification.Name("did-Receive-Payment-Notification")
    static let didChangeNotificationStatus = NSNotification.Name("didChangeNotificationStatus")
}
