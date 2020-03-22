//
//  NotificationView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 22.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    
    
    
    var body: some View {
        Form {
            Section(
                header: Text("Tägliche Benachrichtigung".uppercased())
            ) {
                
                Button("Benachrichtigungen um 12:00 aktivieren") {
                    allowNotifications()
                    scheduleNotification()
                    print("Button schedule Notification pressed.")
                }
            
                Button("Benachrichtigungen um 12:00 deaktivieren") {
                    removeNotification()
                    print("Button remove Notification pressed.")
                }

                Button("Benachrichtigungen anzeigen") {
                    showNotification()
                    print("Button show Notifications pressed.")
                }

            }
        }
        .navigationBarTitle("Benachrichtigungen")
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}



let notificationIdentifier = "dailyAlert"

var getRequest: UNNotificationRequest {
    
    // Content
    let content = UNMutableNotificationContent()
    content.title = NSString.localizedUserNotificationString(
        forKey: "Heute schon Symptome eingetragen?",
        arguments: nil
    )
    content.body = NSString.localizedUserNotificationString(
        forKey: "Trag jeden Tag deine Symptome im SymptomTracker ein.",
        arguments: nil
    )
    content.sound = UNNotificationSound.default
    
    // Trigger
    var dateInfo = DateComponents()
    dateInfo.hour = 17
    dateInfo.minute = 22
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateInfo,
        repeats: false
    )
    
    // Request
    let request = UNNotificationRequest(
        identifier: notificationIdentifier,
        content: content,
        trigger: trigger
    )
    
    return request
    
}

func scheduleNotification() {
    
    let request = getRequest
    
    let center = UNUserNotificationCenter.current()
    center.add(request) { (error: Error?) in
        
        if let theError = error {
            print("Notification error:\n" + theError.localizedDescription)
        }
        
    }
    
    print("Notification scheduled")
    
}

func removeNotification() {
    
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    print("Notification removed.")
    
    
    
}

func showNotification() {
    
    let center = UNUserNotificationCenter.current()
    center.getPendingNotificationRequests() { (requests: [UNNotificationRequest]) in
        
        print("Begin getPendingNotificationRequests")
        for request in requests {
            if request.identifier == notificationIdentifier {
                print("    Found one.")
            }
            
        }
        print("End getPendingNotificationRequests")
        
    }
    print("delegate \((center.delegate != nil) ? "exists" : "= nil")")

}

func allowNotifications() {
    
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        // Enable or disable features based on authorization.
    }

}

class CurrentUserNotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("\(#function)")
        completionHandler(.alert)
        completionHandler(.sound)
    }
    
}

var currentUserNotificationCenterDelegate: CurrentUserNotificationCenterDelegate?

func activateUserNotificationCenterDelegate() {

    let center = UNUserNotificationCenter.current()
    let delegate = CurrentUserNotificationCenterDelegate()
    center.delegate = delegate
    currentUserNotificationCenterDelegate = delegate
    print("\(#function)")
    
}
