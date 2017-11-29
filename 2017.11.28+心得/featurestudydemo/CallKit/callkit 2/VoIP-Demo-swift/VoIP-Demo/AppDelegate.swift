//
//  AppDelegate.swift
//  VoIP-Demo
//
//  Created by Stefan Natchev on 2/5/15.
//  Copyright (c) 2015 ZeroPush. All rights reserved.
//

import UIKit
import PushKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PKPushRegistryDelegate, ZeroPushDelegate {

    var window: UIWindow?
    var viewController: ViewController?

    func registerVoipNotifications() {
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: DispatchQueue.main)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = NSSet(object: PKPushType.voIP) as! Set<PKPushType>
        NSLog("VoIP registered")
        let types: UIUserNotificationType = (UIUserNotificationType.Badge | UIUserNotificationType.Sound | UIUserNotificationType.Alert)
        let notificationSettings = UIUserNotificationSettings(types:types, categories:nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
    }

    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, forType type: PKPushType) {

        let voipZeroPush = ZeroPush()
        //TODO: set your own tokens here
#if DEBUG
        voipZeroPush.apiKey = "iosdev_xxxxxxxxxxx"
#else
        voipZeroPush.apiKey = "iosprod_xxxxxxxxxx"
#endif
        voipZeroPush.registerDeviceToken(credentials.token, channel: "me")

        //UI updates must happen on main thread
        DispatchQueue.main.async(execute: {
            let deviceToken = ZeroPush.deviceTokenFromData(credentials.token)
            NSLog("VoIP Token: %@ subscribed to channel `me`", deviceToken)
            self.viewController?.tokenLabel.text = deviceToken
            self.viewController?.payloadLabel.isHidden = false
        })
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, forType type: PKPushType) {
        //handle push event
        let data = payload.dictionaryPayload
        let notification = UILocalNotification()
        NSLog("%@", data)

        //UI updates must happen on main thread
        DispatchQueue.main.async(execute: {
            let _ = self.viewController?.payloadLabel.text = data.description
        })

        //setup the notification
        let aps = (data["aps"] as! [NSString: AnyObject])
        notification.alertBody = aps["alert"] as NSString!
        notification.category = aps["category"] as NSString!

        UIApplication.shared.presentLocalNotificationNow(notification)
    }

    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenForType type: PKPushType) {
        //unregister
        NSLog("Unregister")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        viewController = self.window?.rootViewController as! ViewController?;
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

