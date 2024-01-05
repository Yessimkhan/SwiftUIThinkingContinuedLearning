//
//  LocalNotificationBootcamp.swift
//  SwiftUIThinkingContinuedLearning
//
//  Created by Yessimkhan Zhumash on 05.01.2024.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instace = NotificationManager()
    
    func requestAuthorization () {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This is sooo easy"
        content.sound = .default
        content.badge = 1
        
        // 1 - Time
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // 2 - Calendar
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 22
//        dateComponents.minute = 58
//        dateComponents.weekday = 2
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 3 - Location
        
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 40.00)
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnExit = true
        region.notifyOnEntry = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instace.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instace.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instace.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    LocalNotificationBootcamp()
}
