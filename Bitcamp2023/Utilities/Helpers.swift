//
//  Helpers.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import Foundation
import FirebaseFirestore

final class Helpers {
    
    /// Whenever you need to save a document, use this function to convert the struct to json that firestore can read
    static func structToJson<T: Codable>(object: T) -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(object)
            return try JSONSerialization.jsonObject(with: data) as? [String: Any]
        } catch {
            print("Error encoding to JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func fetchUserInfoFromFirestore(userID: String, completion: @escaping (UserEntry?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { snapshot, err in
            guard err == nil, let data = snapshot?.data() else {
                print("Error fetching user object: \(String(describing: err))")
                completion(nil)
                return
            }
            completion(jsonToStruct(desiredDecodeType: UserEntry.self, data: data))
        }
    }
    
    /// Firebase returns data with the type [String: Any], however, we want to structure this data so we can access
    /// fields. This function takes the desired data type aka struct that you want to convert the data to and the data
    /// from firebase, and returns an object of your desired data type.
    /// Ex: jsonToStruct(UserEntry.self, data) -> UserEntry
    static func jsonToStruct<T: Codable>(desiredDecodeType: T.Type, data: [String: Any]) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let user = try JSONDecoder().decode(desiredDecodeType.self, from: jsonData)
            return user
        } catch {
            print("Error with data encoding / decoding")
            return nil
        }
    }
}
