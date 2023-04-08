//
//  HomeView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel: UserAuth
    
    var body: some View {
        VStack {
            LottieView()
                .frame(width: 100, height: 100)
            
            Spacer()
//            Button {
//                PlaidRequest.shared.createLinkToken { token in
//                    print("LINK TOKEN: \(token)")
//                }
//            } label: {
//                Text("Get token")
//            }

            Button {
                authViewModel.signOut()
            } label: {
                ButtonDesign(buttonText: "Logout", buttonColor: .red)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
