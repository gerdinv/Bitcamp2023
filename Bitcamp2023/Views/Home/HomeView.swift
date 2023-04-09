//
//  HomeView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct HomeView: View {
    
    let titleSize: CGFloat = 35
    let fontSize: CGFloat = 20
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
            
            
            NetCardView(netIncome: netIncome)
            
            HStack {
                SmallMoneyCardView(label: "gross income", money: grossIncome)
                
                SmallMoneyCardView(label: "spending", money: spending)
            }
            
            
            
            MembersCardView(numMembers: members)
            
            HStack {
                SmallMemberView(label: "top spender", name: topSpender)
                
                SmallMemberView(label: "top saver", name: topSaver)
            }
            
            
            

        }
        .padding()
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
