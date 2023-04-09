//
//  Header.swift
//  Bitcamp2023
//
//  Created by Timothy Lee on 4/8/23.
//

import Foundation


//
//  ContentView.swift
//  bitcampViews
//
//  Created by Sathwik Yanamaddi on 4/8/23.
//
//
//  ContentView.swift
//  bitcampViews
//
//  Created by Sathwik Yanamaddi on 4/8/23.
//

import SwiftUI




struct HeaderView: View {
    
    @EnvironmentObject var dm: DBManager
    
    @State private var isPopupVisible = false
    
    @State private var allGroups: [String] = []
    
    @State var refresh: Bool = false
    
//    @State private var allGroups = ["Friends", "Family", "Church", "Cows", "Bitcamp"]
    @State private var currentGroupIndex: Int = 0
    
    @State private var currentGroup: String = ""
    
    @State private var arrowUp = false
    @State private var showCreateGroupSheet = false
    @State private var showJoinGroupSheet = false
    
    
    func getGroups() {
        dm.getAllGroups(uid: "Tzuyu") {val, error in
            allGroups = val
        }
       
    }

    var body: some View {
        ZStack {
//            Color.green
//                .ignoresSafeArea()

            VStack (spacing: 0){
                HStack {
                    GearButton {
                        // Gear button action
                    }
                    .padding(.leading, 16)
                    Spacer()
                    if !allGroups.isEmpty {
                        GroupButton(groupName: allGroups[currentGroupIndex], arrowUp: $arrowUp) {
                            isPopupVisible.toggle()
                        }
                        .padding(.trailing, -2)
                    }
                    
                    
                    Spacer()

//                    AddGroupButton(refresh: $refresh){
//
//                    }
//                    .padding(.trailing, 23)
                }
                .padding(.bottom, 10)
                .background(isPopupVisible ? Color.clear : Color.clear)
                .animation(.easeIn(duration: 0.2), value: isPopupVisible)

                content
                
                Spacer()
            }
        }
        .onAppear {
            getGroups()
        }
    }
    
    @ViewBuilder
    var content: some View {
        if !allGroups.isEmpty {
            HomeView(selectedGroup: $allGroups[currentGroupIndex], refresh: $refresh)
                .overlay(alignment: .top) {
                    overlay
                }
        }
        
    }
    
    @ViewBuilder
    var overlay: some View {
        if isPopupVisible {
            VStack(alignment: .center, spacing: 0) {
                
                ForEach(0..<allGroups.count) { index in
                    Button(action: {
                        // Move the selected group to the first position in the allGroups array
                        allGroups.insert(allGroups.remove(at: index), at: 0)
                        currentGroupIndex = 0
                        isPopupVisible = false
                        arrowUp.toggle()
                    }) {
                        HStack {

                            
                            Spacer()
                            if (index == currentGroupIndex) {
                                Rectangle()
                                    .frame(width: 5)
                                    .foregroundColor(Color.indigo)
                                
                                Text(allGroups[index])
                                    .foregroundColor(.black)
                                    .frame(maxWidth: 400, alignment: .leading)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .bold()
                                    .padding(.leading, 3)
                                    .frame(height: 60)
                                
                                Image(systemName: "checkmark").foregroundColor(.indigo)
                                Spacer().frame(width: 20)
                            } else {
                                Text(allGroups[index])
                                    .foregroundColor(.black)
                                    .frame(maxWidth: 400, alignment: .leading)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding(.leading, 3)
                            }
                        }.frame(height: 60)
                    }
                    Divider().frame(height: 0.8)
                        .background(Color.gray)
                    
                }
                
                HStack {
                    RoundedButton(title: "Create a Group") {
                        showCreateGroupSheet = true
                    }
                    .sheet(isPresented: $showCreateGroupSheet) {
                        Text("Create a Group Sheet")
                    }
                    
                    RoundedButton(title: "Join a Group") {
                        showJoinGroupSheet = true
                    }
                    .sheet(isPresented: $showJoinGroupSheet) {
                        Text("Join a Group Sheet")
                    }
                }.frame(height: 60)
            }
            .background(Color.white)
            .cornerRadius(0)
            .shadow(radius: 2)
        }
    }
}

struct RoundedButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.light)
                .foregroundColor(.white)
                .padding()
                .frame(width: 180, height: 40)
                .background(Color.indigo)
                .cornerRadius(40)
        }
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}

struct GearButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "gear")
                .font(.system(size: 24))
                .foregroundColor(.indigo)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
        }
    }
}

struct GroupButton: View {
    var groupName: String
    @Binding var arrowUp: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            arrowUp.toggle()
            action()
        }) {
            HStack {
                Text(groupName).padding(.leading, 10)
                Spacer()
                Image(systemName: arrowUp ? "arrow.up" : "arrow.down").padding(.trailing, 10)
            }
            .foregroundColor(.black)
            .fontWeight(.light)
            .frame(height: 40)
            .frame(maxWidth: 200)
            .background(Color.white)
            .cornerRadius(40)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
        }
    }
}

//struct AddGroupButton: View {
////    @Binding var isAvailable: Bool
//
//    @Binding var refresh: Bool
//    var action: () -> Void
//
//    var body: some View {
//
//
//
//        Button {
//
//            refresh = true
//        } label: {
//            Image(systemName: "arrow.clockwise.circle.fill").font(.system(size: 24))
//        }
//            .foregroundColor(.indigo)
//            .frame(width: 40, height: 40)
//
////        Button(action: action) {
//////            Image(systemName: "plus").padding(0).font(.system(size: 14))
////            Image(systemName: "arrow.clockwise.circle.fill").padding(-8).font(.system(size: 24))
////        }
////            .foregroundColor(.indigo)
////            .frame(width: 40, height: 40)
//    }
//}
