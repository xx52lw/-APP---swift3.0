//
//  AppDelegate.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/12.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
// =================================================================================================================================
// MARK: -  总代理
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        application.isStatusBarHidden = false
//        application.statusBarStyle = .lightContent
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        
        addUserNofitions()
        selectShowViewController()
        
        
        window?.makeKeyAndVisible()
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
// =================================================================================================================================
// MARK: -  总代理
extension AppDelegate {

    /// 选择要展示的控制器
    func selectShowViewController() {
        let oldVersion = UserDefaults.standard.string(forKey: LWSystemVersionKey)
        let currentVersion = Bundle.main.version
        if  oldVersion == nil || oldVersion?.compare(currentVersion) == .orderedAscending  {
            window?.rootViewController = UINavigationController(rootViewController : LWNewFeatureViewController())
        }
        else {
            window?.rootViewController = LWTabBarControllerBase()
        }
    }
   /// 设置APNS
    func setAppNotifyInformation() {
        if #available(iOS 10.0, *) {
            // 要导入import UserNotifications
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound], completionHandler: { (success, error) in
                print("授权 " + (success ? "成功" : "失败"))
            })
        }
        else {
            // 取得用户授权显示通知[上方的提示条/声音/BadgeNumber]  ios10以下
            let notifySettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
            
        }
    }
    /// 添加用户通知
    func addUserNofitions(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: LWNewFeatureCompleteNotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectShowViewController), name: NSNotification.Name(rawValue: LWNewFeatureCompleteNotify), object: nil)
    }
    
}

