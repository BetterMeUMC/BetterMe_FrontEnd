//
//  AppDelegate.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //탭바 배경색 변경
        if #available(iOS 15.0, *) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        //바꾸고 싶은 색으로 backgroundColor를 설정
            UITabBar.appearance().backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 250/250, alpha: 1.0)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

