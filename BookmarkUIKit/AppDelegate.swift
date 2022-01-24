//
//  AppDelegate.swift
//  BookmarkUIKit
//
//  Created by Leyla Nyssanbayeva on 20.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(
            rootViewController: MainPageController()
        )
        return true
    }
}

