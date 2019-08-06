//
//  NotificationsHandler.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 28/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

public class NotificationHandler{
    private init(){
    }
    
    private static func askPermission(){
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                permission = false
            }
            else{
                permission = true
            }
        }
    }
    
    private static var permission:Bool?
    private static let notificationCenter:UNUserNotificationCenter = UNUserNotificationCenter.current()
    private static var notifications:[MyNotification] = []
    
    public static func handleNotification(response:UNNotificationResponse){
        var i = 0
        for notification in notifications{
            if notification.identifier == response.notification.request.identifier{
                if let actions = notification.actions{
                    for action in actions{
                        if action.0 == response.actionIdentifier{
                            action.1()
                            notifications.remove(at: i)
                            break
                        }
                    }
                }
            }
            i+=1
        }
    }
    
    public static func notify(title:String, body:String, date:Date, sound:Bool, badges:Bool){
        notify(title: title, body: body, date: date, sound: sound, badges: badges, actions: nil)
    }
    
    public static func notify(title:String, body:String, date:Date, sound:Bool, badges:Bool, actions:[(title:String, action:() -> Void, appReOpens:Bool)]?){
        if let p = permission{
            if !p{
                return
            }
        }
        else{
            askPermission()
        }
        
        let df:DateFormatter = DateFormatter()
        df.dateFormat = "ddMMyy hhmmss ZZZ"
        let identifier = "\(df.string(from: Date()))"
        
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus  == .authorized{
                let userActions:String = "\(identifier) actions"
                
                if let actions = actions{
                    var categoryActions:[UNNotificationAction] = []
                    for action in actions{
                        
                        categoryActions.append(UNNotificationAction(identifier: action.0, title: action.0, options: action.2 ? [.foreground] : []))
                    }
                    
                    let category = UNNotificationCategory(identifier: userActions, actions: categoryActions, intentIdentifiers: [], options: [])
                    
                    self.notificationCenter.setNotificationCategories([category])
                }
                
                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
                content.sound =  sound ? UNNotificationSound.default : nil
                
                
                content.categoryIdentifier = userActions
                
                let calendar = Calendar.autoupdatingCurrent
                var components = calendar.dateComponents([.year], from: date)
                components.year = (components.year ?? 2019) + 1
            
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                self.notificationCenter.add(request, withCompletionHandler: { (error:Error?) in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                })
                notifications.append(MyNotification(identifier: identifier, actions: actions))
            }
        }
    }
}
