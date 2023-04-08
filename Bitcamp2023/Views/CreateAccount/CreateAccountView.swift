//
//  CreateAccountView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var authViewModel: UserAuth
    @Environment(\.dismiss) var dismiss
    
    @State var fullname: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Text("Finance")
                .font(.system(size: 45, weight: .bold))
                .italic()
            
            UserInputField(placeholder: "Fullname",
                           contentType: .emailAddress,
                           image: Image(systemName: "person.text.rectangle"),
                           userInput: $fullname)
            
            UserInputField(placeholder: "Username", contentType: .emailAddress,
                           image: Image(systemName: "person.fill"),
                           userInput: $username)
            
            UserInputField(placeholder: "Email Address", contentType: .emailAddress,
                           image: Image(systemName: "envelope.fill"),
                           userInput: $email)
            
            SecureUserInputField(placeholder: "Password", contentType: .password,
                                 image: Image(systemName: "lock.fill"),
                                 userInput: $password)
            
            SecureUserInputField(placeholder: "Confirm Password", contentType: .password,
                                 image: Image(systemName: "lock.fill"),
                                 userInput: $confirmPassword)
            
            Button {
                authViewModel.createAccount(fullname: fullname, username: username, email: email, password: password)
            } label: {
                ButtonDesign(buttonText: "Create Account", buttonColor: .blue)
                    .padding([.leading, .trailing], 30)
            }
            
            HStack {
                Spacer()
                Text("Already have an account?")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Sign In")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }
            .padding(.bottom, 100)
            Spacer()
        }
        .background(Color("appBg"))
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
