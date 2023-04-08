//
//  SecureUserInputField.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct SecureUserInputField: View {
    
    var placeholder: String
    var contentType: UITextContentType
    var image: Image?
    
    @Binding var userInput: String

    @State private var isSecured: Bool = true
    
    var body: some View {
        HStack {
            if let image = image {
                image
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(.leading, 10)
            }
            
            ZStack {
                if isSecured {
                    SecureField("\(placeholder)", text: $userInput)
                        .textContentType(contentType)
                        .foregroundColor(.primary)
                        .padding(.leading)
                } else {
                    TextField("\(placeholder)", text: $userInput)
                        .textContentType(contentType)
                        .foregroundColor(.primary)
                        .padding(.leading)
                }
            }

            Image(systemName: isSecured ? "eye.slash" : "eye")
                .padding([.trailing, .top, .bottom])
                .foregroundColor(userInput.isEmpty ? .secondary : .primary)
                .opacity(userInput.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    isSecured.toggle()
                }
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("lightContainer"))
        )
        .padding([.leading, .trailing], 25)
    }
}
