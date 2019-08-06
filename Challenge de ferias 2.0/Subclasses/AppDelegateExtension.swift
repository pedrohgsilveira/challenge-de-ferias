//
//  AppDelegateExtension.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 28/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import UserNotifications
extension AppDelegate : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        NotificationHandler.handleNotification(response: response)
        
        completionHandler()
    }
}
