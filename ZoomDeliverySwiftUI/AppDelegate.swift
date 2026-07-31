//
//  AppDelegate.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 15/07/26.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject,
                   UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self

        Messaging.messaging().delegate = self

        application.registerForRemoteNotifications()

        requestPermission()

        return true
    }
}
extension AppDelegate {

    private func requestPermission() {

        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .badge, .sound]
            ) { granted, error in

                print("Permission:", granted)

                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
    }
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {

        Messaging.messaging().apnsToken = deviceToken

        let token = deviceToken.map {
            String(format: "%02.2hhx", $0)
        }.joined()

        print("APNs Token:")
        print(token)
    }
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {

        print(error.localizedDescription)
    }
}
extension AppDelegate: MessagingDelegate {

    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {

        print("FCM Token:")
        print(fcmToken ?? "")
        AppManager.AppDeviceFCMToken = fcmToken ?? ""
        // Send token to your backend
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate {

    // Foreground notification
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {

        print(notification.request.content.userInfo)

        completionHandler([
            .banner,
            .sound,
            .badge
        ])
    }

    // User tapped notification
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler:
        @escaping () -> Void
    ) {

        let data = response.notification.request.content.userInfo

        print(data)

        completionHandler()
    }
}
