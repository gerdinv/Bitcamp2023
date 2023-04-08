//
//  OnboardingView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/8/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var authViewModel: UserAuth
    
    var body: some View {
        VStack {
            Text("Please link your bank account")
                .font(.system(size: 34, weight: .bold))
                .multilineTextAlignment(.center)
            
            Button {
                // call link pank
//                PlaidRequest.shared.createLinkToken { token in
//                    guard let token else { return }
//                    print("LINK TOKEN: \(token)")
//
//                    authViewModel.updateLinkTokenForUser(linkToken: token)
//                }
            } label: {
                ButtonDesign(buttonText: "Link Bank", buttonColor: .blue)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
