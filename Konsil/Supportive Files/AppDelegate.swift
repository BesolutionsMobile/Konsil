//
//  AppDelegate.swift
//  UsingFiles
//
//  Created by Tim Richardson on 10/05/2018.
//  Copyright © 2018 iOS Mastery. All rights reserved.
//

import UIKit
import MOLH
import Firebase
import BiometricAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , MOLHResetable {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")
        
        FirebaseApp.configure()
        
        let didLunchedBefore = UserDefaults.standard.bool(forKey: Key.launchedBefore)
        if !didLunchedBefore {
            UserDefaults.standard.set(true, forKey: Key.launchedBefore)
            UserDefaults.standard.synchronize()
            let storboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 13.0, *) {
                if let vc = storboard.instantiateViewController(identifier: "Walkthrough1") as? Walkthrough1ViewController {
                    window?.makeKeyAndVisible()
                    window?.rootViewController = vc
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        let biometricAuth = UserDefaults.standard.bool(forKey: Key.prefereBiometricAuth)
        if biometricAuth {
            let topController = self.window?.rootViewController?.topViewController()
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 13.0, *) {
                if let fingerPrintVC = storyBoard.instantiateViewController(identifier: "Lock") as? FingerPrintViewController {
                    fingerPrintVC.modalPresentationStyle = .overFullScreen
                    topController?.present(fingerPrintVC, animated: true, completion: nil)
                }
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func reset() {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: "Main", bundle: nil)
        rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: "MainNavigation")
    }
}

