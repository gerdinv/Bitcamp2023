//
//  UserAuth.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import LinkKit

final class UserAuth: ObservableObject {
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    @Published var user: User? = nil
    @Published var userEntry: UserEntry? = nil
    @Published var errorWithRequest: Bool = false
    
    func createAccount(fullname: String, username: String, email: String, password: String) {
        print("\nSending create account request...\n")
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self, error == nil, let user = authResult?.user else {
                print("Error creating user!")
                return
            }
            
            PlaidRequest.shared.createLinkToken(userID: user.uid) { token in
                guard let token else { return }
                print("LINK TOKEN: \(token)")
                
                PlaidRequest.shared.exchangePublicToken(publicToken: token) { accessToken in
                    let userEntry = UserEntry(uid: user.uid, fullname: fullname, username: username,
                                              email: email, linkToken: token, accessToken: accessToken, lists: [])
                    if let jsonData = Helpers.structToJson(object: userEntry) {
                        strongSelf.db.collection("users").document(user.uid).setData(jsonData)
                    }                    
                    strongSelf.user = user
                }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        print("\nSending sign in request...\n")
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self, error == nil, let user = authResult?.user else {
                self?.errorWithRequest = true
                return
            }
            strongSelf.user = user
        }
    }
    
    func updateLinkTokenForUser(linkToken: String) {
        guard let uid = self.user?.uid else { return }
        db.collection("users").document(uid).updateData([
            "linkToken": linkToken
        ])
    }
    
    func forgotPassword(email: String) {
        auth.sendPasswordReset(withEmail: email)
    }
    
    func checkUserState() {
        auth.addStateDidChangeListener { [weak self] _, user in
            print("Checking user state...")
            guard let strongSelf = self else { return }
            DispatchQueue.main.async { strongSelf.user = user }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
