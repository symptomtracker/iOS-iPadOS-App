//
//  NotificationView.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 22.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    
    // nil means unknown state
    @State private var hasActiveNotification: Bool? = nil
    var toggleIsDisabled: Bool {
        hasActiveNotification == nil
    }
    
    func updateHasActiveNotificationState() {
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests() { (requests: [UNNotificationRequest]) in
            
            let isEmtpy = requests.filter({ $0.identifier == notificationIdentifier }).isEmpty
            self.hasActiveNotification = !isEmtpy
                        
        }

    }
    
    var body: some View {
        
        let isNotificationActiveBinding: Binding<Bool> = Binding(
            get: {
                return self.hasActiveNotification ?? false
            },
            set: {
                if $0 {
                    askToAllowNotifications()
                    scheduleNotification()
                    self.hasActiveNotification = true
                } else {
                    removeNotification()
                    self.hasActiveNotification = false
                }
            }
        )
       
        return Form {
            Section(
                header: Text("Tägliche Benachrichtigung".uppercased()),
                footer: Text("Sie werden jeden Tag um 12:00 mit einer Benachrichtigung daran erinnert, Ihre Symptome im SymptomTracker einzutragen.")
            ) {
                
                Toggle("Benachrichtigung", isOn: isNotificationActiveBinding)
                .disabled(toggleIsDisabled)
                
                Button("DEBUG: Benachrichtigungen anzeigen") {
                    showNotification()
                }

            }
        }
        .navigationBarTitle("Benachrichtigungen")
        .onAppear {
            self.updateHasActiveNotificationState()
        }
        
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

func askToAllowNotifications() {
    
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        // TODO.
    }

}
