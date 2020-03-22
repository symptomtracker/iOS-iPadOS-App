//
//  CurrentUNCenterDelegate.swift
//  symptomtracker
//
//  Created by Wolf Dieter Dallinger on 22.03.20.
//  Copyright © 2020 Wolf Dieter Dallinger. All rights reserved.
//

import SwiftUI

class CurrentUserNotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
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
    
}
