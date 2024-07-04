//
//  PushNotificationSetupStep.swift
//  Cardizerr Admin
//
//  Created by Osama Abu hdba on 09/08/2023.
//

import UIKit
import UserNotifications

extension DefaultSetupSteps {
    struct PushNotificationSetupStep: AppSetupStepType {
        func setup(for application: UIApplication, delegate: AppDelegate, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
            UNUserNotificationCenter.current().delegate = delegate as UNUserNotificationCenterDelegate
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                guard granted else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        preferencesManager.deviceToken = deviceToken

      // 1. Convert device token to string
      let tokenParts = deviceToken.map { data -> String in
        return String(format: "%02.2hhx", data)
      }
      let token = tokenParts.joined()
      // 2. Print device token to use for PNs payloads
      print("Device Token: \(token)")
//        preferencesManager.apnToken = token
      let bundleID = Bundle.main.bundleIdentifier;
        print("Bundle ID: \(token) \(String(describing: bundleID))");
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        preferencesManager.deviceToken = nil
      print("failed to register for remote notifications: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {

      print("Received push notification: \(userInfo)")
      let aps = userInfo["aps"] as! [String: Any]
      print("\(aps)")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        if UIApplication.getTopViewController() is NewHomeVC || UIApplication.getTopViewController() is ChatVC {
//            completionHandler([])
//            NotificationCenter.default.post(name: AppNotifications.didReceivePaymentNotification, object: nil)
//        } else {
//            completionHandler([.list,.banner, .sound])
//        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier
        let userInfo = response.notification.request.content.userInfo

        let dict: [AnyHashable: Any] = userInfo
               do {
                   let jsonData = try JSONSerialization.data(withJSONObject: dict)
               }
               catch {
                   print(error)
               }

//        if let data = userInfo["aps"] as? [String: Any],
//           let alert = data["alert"] as? [String: Any],
//           let mobile = alert["body"] as? String{
//            if let range = mobile.range(of: "from ") {
//                let phone = mobile[range.upperBound...]
//                preferencesManager.latestPaymentFromNotification = "\(phone)"
//            }
//        }else{
//            print("there is no mobile number or id to save from notification")
//        }

        switch actionIdentifier {
        case UNNotificationDismissActionIdentifier: // Notification was dismissed by user

            completionHandler()
        case UNNotificationDefaultActionIdentifier: // App was opened from notification

//            let userPool = AppDelegate.defaultUserPool()
//            print(userPool)
//            if let userFromPool = userPool.currentUser() {
//                guard let _ = userFromPool.getSession().result?.idToken?.tokenString as? String  else { return }
//                let newHomeVC = UIApplication.getTopViewController()?.initViewControllerWith(identifier: NewHomeVC.className, storyboardName: Storyboard.home.rawValue) as! NewHomeVC
//                UIApplication.getTopViewController()?.show(newHomeVC)
//            } else {
//                // if not login will go first to Sign in page then the conversation
//            }

            completionHandler()
        default:
            completionHandler()
        }
    }

    func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {

        let state : UIApplication.State = application.applicationState
            if (state == .inactive || state == .background) {
                // go to screen relevant to Notification content
                print("background")
            } else {
                // App is in UIApplicationStateActive (running in foreground)
                print("foreground")
                showLocalNotification()
            }
        }

    fileprivate func showLocalNotification() {

            //creating the notification content
            let content = UNMutableNotificationContent()

            //adding title, subtitle, body and badge
            content.title = ""
            //content.subtitle = "local notification"
            content.body = ""
            //content.badge = 1
            content.sound = UNNotificationSound.default


            //getting the notification trigger
            //it will be called after 5 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            //getting the notification request
            let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)


            //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
}
