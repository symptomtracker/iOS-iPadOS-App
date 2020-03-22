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
    
    private var toggleIsDisabled: Bool { hasActiveNotification == nil }
    
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
                header: Text("Tägliche Erinnerung".uppercased()),
                footer: Text("Sie werden jeden Tag um 12:00 mit einer Benachrichtigung daran erinnert, Ihre Symptome im SymptomTracker einzutragen.")
            ) {
                
                Toggle("Erinnerung", isOn: isNotificationActiveBinding)
                .disabled(toggleIsDisabled)
                
            }
        }
        .navigationBarTitle("Erinnerungen", displayMode: .inline)
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
        forKey: "Tragen Sie jeden Tag Ihre Symptome im SymptomTracker ein!",
        arguments: nil
    )
    content.sound = UNNotificationSound.default
    
    // Trigger
    var dateInfo = DateComponents()
    dateInfo.hour = 12
    dateInfo.minute = 0
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
    
}

func removeNotification() {
    
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    
}

func askToAllowNotifications() {
    
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        // TODO.
    }

}
