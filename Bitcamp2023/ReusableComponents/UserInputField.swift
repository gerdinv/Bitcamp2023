//
//  UserInputField.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct UserInputField: View {
    
    var placeholder: String
    var contentType: UITextContentType
    var image: Image?
    
    @Binding var userInput: String
    
    var body: some View {
        HStack(spacing: 0) {
            if let image = image {
                image
                    .resizable()
                    .frame(width: 14, height: 15)
                    .padding(.leading, 10)
            }
            TextField("\(placeholder)", text: $userInput)
                .textContentType(contentType)
                .foregroundColor(.primary)
                .padding(.leading)
            Image(systemName: "xmark.circle.fill")
                .padding([.trailing, .top, .bottom])
                .foregroundColor(userInput.isEmpty ? .secondary : .primary)
                .opacity(userInput.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    userInput = ""
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
