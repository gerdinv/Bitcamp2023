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
    
    var netIncome = 0
    var grossIncome = 0
    var spending = 0
    @State var members = 0
    @State var topSpender = "-"
    @State var topSaver = "-"
    
    @State var expenses = 0
    @State var income = 0
    
    @Binding var selectedGroup: String
    @Binding var refresh: Bool
    
    @State var test:[String] = []
    
    @EnvironmentObject var dm: DBManager
    
    
    let monthAndYear: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM ''yy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = Date()
        return dateFormatter.string(from: date).uppercased()
    }()
    
    func getExpenses() -> Int {
        expenses = 0
        for i in test {
            dm.getExpenses(uid: i) { val, error in
                for (_,v) in val {
                    expenses += v
                }
            }
        }
        return expenses
    }
    
    func getIncome() -> Int {
        income = 0
        for i in test {
            dm.getIncome(uid: i) { val, error in
                income+=val
            }
        }
        return income
    }
    
    
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            
            
            Text(monthAndYear)
                .font(.system(size: titleSize, weight: .bold))
                .textCase(.uppercase)
            
            
            NetCardView(netIncome: Double(income - expenses))
            
            HStack {
                SmallMoneyCardView(label: "gross income", money: Double(income))
                
                SmallMoneyCardView(label: "spending", money: Double(expenses))
            }
            
            
            
            MembersCardView(numMembers: members)
            
            HStack {
                SmallMemberView(label: "top spender", name: topSpender)
                
                SmallMemberView(label: "top saver", name: topSaver)
            }
            
            Button {
                
                
                 
                
                if selectedGroup == "Roommates" {
                    test = ["Tzuyu","Momo","Sana"]
                    topSpender = "Momo"
                    members = 3
                    topSaver = "Tzuyu"
                } else if selectedGroup == "Friends" {
                    test = ["John Doe", "Tzuyu"]
                    topSpender = "Sana"
                    members = 2
                    topSaver = "John Doe"
                } else {
                    test = ["Tzuyu"]
                    members = 1
                    topSpender = "Aang"
                    topSaver = "Sana"
                }
                
                
                getIncome()
                getExpenses()
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill").font(.system(size: 24))
            }
            .position(x: 340, y: -610)
                .foregroundColor(.indigo)
            

            
            

        }
        .padding()
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedGroup: .constant("Roommates"), refresh: .constant(false))
    }
}
