//
//  Bitcamp2023App.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

@main
struct Bitcamp2023App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        
        let authViewModel: UserAuth = UserAuth()
        
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .onAppear() {
                    authViewModel.checkUserState()
                }
        }
    }
}
