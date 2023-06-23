//
//  NotificationManager.swift
//  mini1
//
//  Created by Gustavo Munhoz Correa on 23/06/23.
//

import UserNotifications

class NotificationManager {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied because: \(error?.localizedDescription ?? "an error occurred")")
            }
        }
    }
}
