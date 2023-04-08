//
//  ButtonDesign.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

struct ButtonDesign: View {
    var buttonText: String
    var buttonColor: Color
    var textColor: Color = .white
    
    var body: some View {
        Text("\(buttonText)")
            .font(.system(size: 17, weight: .bold))
            .frame(width: screenWidth - 50, height: 55)
            .background(buttonColor)
            .foregroundColor(textColor)
            .cornerRadius(10)
    }
}
