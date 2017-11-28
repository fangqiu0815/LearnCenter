//
//  ManagementViewController.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

class ManagementViewController: UIViewController {

    let title1Content: UNNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "1"
        content.body = "Notification 1"
        return content
    }()
    
    let title2Content: UNNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "2"
        content.body = "Notification 2"
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pendingRemovalPressed(_ sender: AnyObject) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.pendingRemoval.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier)")
            }
        }
        
        // 第二秒移除本地通知
        delay(2) {
            print("Notification request removed: \(identifier)")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    
    @IBAction func pendingUpdatePressed(_ sender: AnyObject) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.pendingUpdate.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier) with title1")
            }
        }
        // 替换通知的内容
        delay(2) {
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            // Add new request with the same identifier to update a notification.
            let newRequest = UNNotificationRequest(identifier: identifier, content: self.title2Content, trigger: newTrigger)
            UNUserNotificationCenter.current().add(newRequest) { error in
                if let error = error {
                    UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
                } else {
                    print("Notification request updated: \(identifier) with title2")
                }
            }
        }
    }
    
    @IBAction func deliveredRemovalPressed(_ sender: AnyObject) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.deliveredRemoval.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier)")
            }
        }
        
        delay(4) {
            print("Notification request removed: \(identifier)")
            // 貌似不符合预期
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
        }
    }
    
    // This is for local notification. To update a remote notification, 
    // you need to set the identifier as the value of `apns-collapse-id` key in an HTTP/2 request header.
    @IBAction func deliveredUpdatePressed(_ sender: AnyObject) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.pendingUpdate.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier) with title1")
            }
        }
        // 表现有点奇怪，为什么更新的推送，要应用回到前台后才会出来，会推送两次，但是通知中心只有最新数据
        delay(4) {
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            // Add new request with the same identifier to update a notification.
            let newRequest = UNNotificationRequest(identifier: identifier, content: self.title2Content, trigger: newTrigger)
            UNUserNotificationCenter.current().add(newRequest) { error in
                if let error = error {
                    UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
                } else {
                    print("Notification request updated: \(identifier) with title2")
                }
            }
        }

    }
    
}
