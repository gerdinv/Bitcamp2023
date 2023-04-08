//
//  ContentView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var authViewModel: UserAuth

    var body: some View {
        if authViewModel.user == nil {
            LoginView()
                .environmentObject(authViewModel)
        } else {
            TabView {
                // add all items below
                HomeView().tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
            }
            .onAppear() {
                authViewModel.checkUserState()
            }
            .environmentObject(authViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}