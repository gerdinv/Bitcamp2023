//
//  UserEntry.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import Foundation


struct UserEntry: Codable, Hashable {
    let uid: String
    let fullname: String
    let email: String
    var expenses: [String: Int]
    var income: Double
    var groups: [String]
}

struct GroupEntry: Codable, Hashable {
    let gid: String
    let groupCode: String
    let users: [String]
}

//  GroupManager.swift
//  Bitcamp2023
//
//  Created by Dalton Pang on 4/8/23.
//
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class DBManager: ObservableObject {
    
    static let shared = DBManager()
    let db : Firestore
    init () {
        FirebaseApp.configure()
        db = Firestore.firestore()
    }

    //User management
//    func updateExpenses(uid: String, key: String, value: Int) {
//        if uid.isEmpty || key.isEmpty { return }
//        let docSnapshot = self.db.collection("users").document(uid)
//        docSnapshot.getDocument() { doc, error in
//            if let doc = doc, doc.exists {
//                docSnapshot.setData(["expenses": [key:value]],merge:true)
//            }
//        }
//    }
    
    func getAllGroups(uid: String, completion: @escaping ([String], Error?) -> Void){
        let docSnapshot = self.db.collection("users").document(uid)
        docSnapshot.getDocument() { doc, error in
            if let doc = doc, doc.exists {
                completion(doc.data()?["groups"] as? [String] ?? [], nil)
            }
        }
    }
    
    func getIncome(uid: String, completion: @escaping (Int, Error?) -> Void) {
        let docSnapshot = self.db.collection("users").document(uid)
        docSnapshot.getDocument() { doc, error in
            if let doc = doc, doc.exists {
                completion(doc.data()?["income"] as? Int ?? 0, nil)
            }
        }
    }
    
    func getExpenses(uid: String, completion: @escaping ([String:Int], Error?) -> Void){
        let docSnapshot = self.db.collection("users").document(uid)
        docSnapshot.getDocument() { doc, error in
            if let doc = doc, doc.exists {
                completion(doc.data()?["expenses"] as? [String:Int] ?? [:], nil)
            }
        }
    }
    

    func updateExpenses(uid: String, income: Int, rent:Int, groceries:Int, shopping:Int, misc:Int) {
            let docSnapshot = self.db.collection("users").document(uid)
            docSnapshot.getDocument() { doc, error in
                if let doc = doc, doc.exists {
                    docSnapshot.updateData(["expenses": ["rent":rent,"groceries":groceries,"shopping":shopping,"misc":misc]])
                    docSnapshot.updateData(["income":income])
                }
            }
        }
    
    
    //Group management
    func createGroup(id: String, users: [String]) {
        let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let groupCode = String((0..<6).map { _ in chars.randomElement()! })
        
        let groupEntry = GroupEntry(gid: id, groupCode: groupCode, users: users)
        
        if let jsonData = Helpers.structToJson(object: groupEntry) {
            self.db.collection("groups").document(groupEntry.gid).setData(jsonData)
        }
    }
    
    func addGroup(gid: String, groupCode: String, user: String) {
        if user.isEmpty { return }
        let docSnapshot = self.db.collection("groups").document(gid)
        docSnapshot.getDocument() { doc, error in
            if let doc = doc, doc.exists {
                docSnapshot.updateData(["users": FieldValue.arrayUnion([user])])
            }
        }
    }
    func delGroup(gid: String) {
        self.db.collection("groups").document(gid).delete()
    }
    
    func getGroupMembers(gid: String,completion: @escaping ([String], Error?) -> Void) {
        let docSnapshot = self.db.collection("groups").document(gid)
        docSnapshot.getDocument() { doc, error in
            if let doc = doc, doc.exists {
                print(doc)
                completion(doc.data()?["users"] as? [String] ?? [], nil)
            }
        }
    }
    
    func getGroupExpenses(gid:String) -> Int {
        var users:[String] = []
        print("here")
        getGroupMembers(gid: gid) { val, error in
            users = val
        }
        var total = 0
        for i in users {
            getExpenses(uid: i) { val, error in
                for (_,v) in val {
                    total+=v
                    print(total)
                }
            }
        }
        return total
    }
}
