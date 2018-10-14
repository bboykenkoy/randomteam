//
//  AppDelegate.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/13/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        let tabbarAppearance = UITabBar.appearance()
        tabbarAppearance.tintColor = DARK_BASE_COLOR
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = DARK_BASE_COLOR
        navigationBarAppearace.barTintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor : DARK_BASE_COLOR]
        navigationBarAppearace.isTranslucent = false
        
        
        self.checkAuthenticate()
        return true
    }

    func checkAuthenticate(){
        if App.shared.currentUser.token.count > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MAIN_TABBAR")
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LOGGIN")
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
        if App.shared.currentUser.token.count > 0 && App.shared.currentUser.refreshToken.count > 0  {
            let params = ["token": App.shared.currentUser.refreshToken,
                          "policiesAccepted":"true"]
            Service().refresh(info: params as! [String : AnyObject]) { (JSON) in
                let token = JSON["token"].string ?? ""
                if token.count > 0 {
                    App.shared.currentUser.updateToken(token: token)
                }
            }
        }
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

