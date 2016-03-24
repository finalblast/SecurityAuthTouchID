//
//  AppDelegate.swift
//  SecurityAuthTouchID
//
//  Created by Nam (Nick) N. HUYNH on 3/23/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let key = "Full Name"
        let value = "Nam Huynh"
        let valueData = value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let accessGroup = "F3FU372W5M.*"
        
        let service = NSBundle.mainBundle().bundleIdentifier!
        let secItem = [
            kSecClass as NSString: kSecClassGenericPassword as NSString,
            kSecAttrService as NSString: service,
            kSecAttrAccount as NSString: key,
            kSecValueData as NSString: valueData!
        ] as NSDictionary
        
        var result: Unmanaged<AnyObject>? = nil
        let status = Int(SecItemAdd(secItem, &result))
        switch status {
            
        case Int(errSecSuccess):
            println("Successfully stored the value")
        case Int(errSecDuplicateItem):
            let query = [
                kSecClass as NSString: kSecClassGenericPassword as NSString,
                kSecAttrService as NSString: service,
                kSecAttrAccessGroup as NSString : accessGroup,
                kSecAttrAccount as NSString: key,
                kSecAttrSynchronizable as NSString: kCFBooleanTrue
//                kSecReturnAttributes as NSString: kCFBooleanTrue
            ] as NSDictionary
            
            SecItemDelete(query)
            
            var valueAttr: Unmanaged<AnyObject>? = nil
            let results = Int(SecItemCopyMatching(query, &valueAttr))
            if results == Int(errSecSuccess) {
                
                println("Good")
                
                let newData = "Nick".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                let update = [
                    kSecValueData as NSString: newData!,
                    kSecAttrComment as NSString: "First Update"
                ] as NSDictionary
                
                let updated = Int(SecItemUpdate(query, update))
                if updated == Int(errSecSuccess) {
                    
                    println("Updated")
                    
                } else {
                    
                    println("Updating failed! \(updated)")
                    
                }
                
            }
            
        default:
            println("An error occurred with code \(status)")
            
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

