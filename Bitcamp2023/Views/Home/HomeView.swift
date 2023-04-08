//
//  HomeView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct HomeView: View {
    
    let titleSize: CGFloat = 38
    let fontSize: CGFloat = 30
    let subscriptFontSize: CGFloat = 23
    
    var netIncome = 12834.00
    var grossIncome = 15104.00
    var spending = 2270.64
    var members = 4
    var topSpender = "Gerdin"
    var topSaver = "Sathwik"
    
    
    let monthAndYear: String = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM ''yy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let date = Date()
            return dateFormatter.string(from: date).uppercased()
        }()
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            
            Text(monthAndYear)
                .font(.system(size: titleSize, weight: .bold))
                .textCase(.uppercase)
           
                            
            
            
            HStack {
                
                Text("NET INCOME")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                Text("💰")
                    .font(.system(size: fontSize))
                Text("$\(netIncome, specifier: "%.2f")")
                    .font(.system(size: subscriptFontSize, weight: .bold, design: .default))
                    .baselineOffset(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            HStack {
                
                Text("Gross INCOME")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                Text("💲")
                    .font(.system(size: fontSize))
                Text("$\(grossIncome, specifier: "%.2f")")
                    .font(.system(size: subscriptFontSize, weight: .bold, design: .default))
                    .baselineOffset(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                
                Text("SPENDING")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                Text("💸")
                    .font(.system(size: fontSize))
                Text("$\(spending, specifier: "%.2f")")
                    .font(.system(size: subscriptFontSize, weight: .bold, design: .default))
                    .baselineOffset(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                
                Text("MEMBERS")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                Text("👥")
                    .font(.system(size: fontSize))
                Text("\(members)")
                    .font(.system(size: subscriptFontSize, weight: .bold, design: .default))
                    .baselineOffset(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                
                Text("TOP SPENDER")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                Text("🏆")
                    .font(.system(size: fontSize))
                Text("\(topSpender)")
                    .font(.system(size: subscriptFontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                    .baselineOffset(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                
                Text("TOP Saver")
                    .font(.system(size: fontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                Text("🛟")
                    .font(.system(size: fontSize))
                Text("\(topSaver)")
                    .font(.system(size: subscriptFontSize, weight: .bold, design: .default))
                    .textCase(.uppercase)
                    .baselineOffset(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
