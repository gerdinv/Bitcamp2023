//
//  FormView.swift
//  Bitcamp2023
//
//  Created by Timothy Lee on 4/9/23.
//

import Foundation


//
//  ContentView.swift
//  bitcampViews
//
//  Created by Sathwik Yanamaddi on 4/9/23.
//


import SwiftUI

struct FormView: View {
    
    @EnvironmentObject var dm: DBManager
    
    @State private var income = ""
    @State private var rent = ""
    @State private var groceries = ""
    @State private var shopping = ""
    @State private var misc = ""

    private var total: Double {
        let incomeValue = Double(income) ?? 0
        let rentValue = Double(rent) ?? 0
        let groceriesValue = Double(groceries) ?? 0
        let shoppingValue = Double(shopping) ?? 0
        let miscValue = Double(misc) ?? 0
        
        return (rentValue + groceriesValue + shoppingValue + miscValue)
    }

    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Income")){
                    TextField("By month", text: $income)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Expenses")) {
                    TextField("Rent", text: $rent)
                        .keyboardType(.decimalPad)
                    
                    TextField("Groceries", text: $groceries)
                        .keyboardType(.decimalPad)
                    
                    TextField("Shopping", text: $shopping)
                        .keyboardType(.decimalPad)
                    
                    TextField("Misc.", text: $misc)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Text("Total Expenses:    \(total, specifier: "%.2f")")
                }
                
                Button(action: saveButtonTapped) {
                    Text("Save")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationBarTitle("Budget Entry")
        }
    }
    
    func saveButtonTapped() {
        dm.updateExpenses(uid: "Tzuyu", income: Int(income)!, rent: Int(rent)!, groceries: Int(groceries)!, shopping: Int(shopping)!, misc: Int(misc)!)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
