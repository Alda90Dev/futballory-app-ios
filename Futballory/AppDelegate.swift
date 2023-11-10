//
//  AppDelegate.swift
//  Futballory
//
//  Created by Aldair Carrillo on 01/11/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = SplashRouter.createSplashModule()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    
    func createAppMainTabBar(success: @escaping () -> ()) {
        let viewController = MainTabBarViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        success()
    }
}
