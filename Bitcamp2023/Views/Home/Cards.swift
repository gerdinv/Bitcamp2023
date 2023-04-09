//
//  Cards.swift
//  Bitcamp2023
//
//  Created by Timothy Lee on 4/8/23.
//

import Foundation
import SwiftUI



struct NetCardView: View {
    
    let netIncome: Double

    var body: some View {
        ZStack {
            Color.green.opacity(0.4)
            
            VStack() {
                Text("net income:")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .textCase(.lowercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                    .padding(.top, -30)
                
                Text("$\(netIncome, specifier: "%.2f")")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .textCase(.lowercase)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 6)
        .cornerRadius(20)
    }
}

struct SmallMoneyCardView: View {
    
    let label: String
    let money: Double
    
    let fontSize: CGFloat = 20
    

    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
            
            VStack {
                
                Text("\(label):")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.lowercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, -20)
                    .padding(.bottom, 5)

                    .font(.system(size: fontSize))
                Text("$\(money, specifier: "%.2f")")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                 
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: UIScreen.main.bounds.height / 8)
        .cornerRadius(20)
    }
}

struct MembersCardView: View {

    let numMembers: Int
    
    let fontSize: CGFloat = 20
    

    var body: some View {
        ZStack {
            Color.purple.opacity(0.4)
            
            HStack {
                
                Text("members:")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.lowercase)
                    .padding(.leading, 10)

                    .font(.system(size: fontSize))
                Text("\(numMembers)")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                 
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: UIScreen.main.bounds.height / 12)
        .cornerRadius(20)
    }
}



struct SmallMemberView: View {
    
    let label: String
    let name: String
    
    let fontSize: CGFloat = 20
    

    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
            
            HStack {
                
                Text("\(label): \(name)")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.lowercase)
                    .padding(.leading, 10)
                    .font(.system(size: fontSize))
//                Text("$\(name)")
//                    .font(.system(size: fontSize, weight: .bold, design: .default))
                 
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: UIScreen.main.bounds.height / 12)
        .cornerRadius(20)
    }
}
