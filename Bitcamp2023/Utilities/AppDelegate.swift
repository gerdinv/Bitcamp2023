//
//  AppDelegate.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import Foundation
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
