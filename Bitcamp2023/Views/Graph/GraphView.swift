//
//  GraphView.swift
//  Bitcamp2023
//
//  Created by Timothy Lee on 4/8/23.
//

import SwiftUI
import Charts


struct Series: Identifiable {
    let viewType: String
    let users: [TempUser]
    
    var id: String { viewType }
}


struct GraphView: View {
    
    
    @State var users: [TempUser] = [
        TempUser(name: "Tim", categories: ["rent", "groceries", "shopping"], costs: [1080.00, 775.00, 287.45]),
        TempUser(name: "Dalton", categories: ["rent", "groceries", "shopping"], costs: [700.00, 687.00, 400.45]),
        TempUser(name: "Sathwik", categories: ["rent", "groceries", "shopping"], costs: [530.10, 68.00, 40.45]),
    ]
    
    // used .crew cuz .group is a thing
//    @State var meGroup: MeGroup = .crew
    
    let tempData = [
        (spendCategory: "rent", data: SpendingCategory.rent),
        (spendCategory: "Groceries", data: SpendingCategory.groceries),
        (spendCategory: "Shoppin", data: SpendingCategory.shopping),
        (spendCategory: "misc", data: SpendingCategory.misc),
    ]
    
    var body: some View {
        VStack {
//            Picker("Tog", selection: $meGroup) {
//                Text("Me").tag(MeGroup.me)
//                Text("Group").tag(MeGroup.crew)
//            }
            
            VStack {
                Chart {
                    ForEach(tempData, id: \.spendCategory) { element in
                        ForEach(element.data) {
                            BarMark(x: .value("Person", $0.name), y: .value("Expense", $0.money))
                                
                        }
                        .foregroundStyle(by: .value("Workout(type)", element.spendCategory))
                    }
                }
            }
            .padding()
        }
    }
}


struct SpendingCategory: Identifiable {
    
    let id = UUID()
    
    let name: String
    let money: Double
    

}

extension SpendingCategory {
    static let rent: [SpendingCategory] = [
        .init(name: "Tim", money: 999.00),
        .init(name: "Dalton", money: 1050.00),
        .init(name: "Gerdin", money: 999.00),
        .init(name: "Ohsung", money: 810.0),
    ]
    
    static let misc: [SpendingCategory] = [
        .init(name: "Tim", money: 109.0),
        .init(name: "Dalton", money: 250.0),
        .init(name: "Gerdin", money: 67.0),
        .init(name: "Ohsung", money: 100.0),
    ]
    
    static let groceries: [SpendingCategory] = [
        .init(name: "Tim", money: 500.0),
        .init(name: "Dalton", money: 800.0),
        .init(name: "Gerdin", money: 999.00),
        .init(name: "Ohsung", money: 810.0),
    ]
    
    static let shopping: [SpendingCategory] = [
        .init(name: "Tim", money: 999.00),
        .init(name: "Dalton", money: 1050.00),
        .init(name: "Gerdin", money: 999.00),
        .init(name: "Ohsung", money: 810.0),
    ]
}






struct TempUser: Identifiable {
    var name: String
    var spending: [String: Double] = [:]
    var id: String
    
    init(name: String, categories: [String], costs: [Double]) {
        self.name = name
        self.id = name
        for (category, cost) in zip(categories, costs) {
            addSpending(category: category, price: cost)
        }
        
    }
    
    // Add spending for a category
    mutating func addSpending(category: String, price: Double) {
        if let currentPrice = spending[category] {
            spending[category] = currentPrice + price
        } else {
            spending[category] = price
        }
    }
    
    func getTotalSpending() -> Double {
        return spending.values.reduce(0, +)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
