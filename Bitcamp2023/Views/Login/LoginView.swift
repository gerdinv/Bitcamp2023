//
//  LoginView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: UserAuth
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Spacer()
                Text("Finance")
                    .font(.system(size: 45, weight: .bold))
                    .italic()
                
                UserInputField(placeholder: "Email", contentType: .emailAddress, userInput: $email)
                    
                
                SecureUserInputField(placeholder: "Password", contentType: .password, userInput: $password)
                
                
                Button {
                    authViewModel.signIn(email: email, password: password)
                } label: {
                    ButtonDesign(buttonText: "Login", buttonColor: .blue)
                        .padding([.leading, .trailing], 30)
                }
//                .disableWithOpacity(email.isEmpty || password.isEmpty)
                
                NavigationLink {
                    CreateAccountView()
                } label: {
                    ButtonDesign(buttonText: "Create Account", buttonColor: .gray)
                        .padding([.leading, .trailing], 30)
                }

                Spacer(minLength: 250)
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
