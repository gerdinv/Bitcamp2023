//
//  PlaidRequests.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/8/23.
//

import Foundation

class PlaidRequest {
    static let shared = PlaidRequest()
    
    //    secret for sandbox
    private let clientId = "62a96294787ab8001324612d"
    private let secret = "f09c24be0ba27a3a85725d6c294dbe"
    private let environment = "sandbox"
    
    // Creds for development
//    private let clientId = "62a96294787ab8001324612d"
//    private let secret = "074fc7db26b0208598b26db9e12187"
//
    
//    private let environment = "development" // Change to "development" or "production" when using real credentials

    
    private init() {}
    
    
    /*
     link-sandbox-5b1d08b0-4696-4f2f-bf35-58e7e4baec45
     link-sandbox-98e10244-645b-45ed-8d3b-57fba5bbfe69
     -> link-sandbox-2f7e2d99-677e-471b-bc7a-2e2b6928f9bd
     
     */
    func createLinkToken(userID: String, completion: @escaping (String?) -> Void) {
        // Warning: Do not use this method in a production application
        // Your Plaid secret key should never be exposed in a client-side app

        guard let url = URL(string: "https://\(environment).plaid.com/link/token/create") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let parameters = [
            "client_id": clientId,
            "secret": secret,
            "client_name": "Your App Name",
            "products": ["auth", "transactions"],
            "country_codes": ["US"],
            "language": "en",
            "user": [
                "client_user_id": "god" // Replace with a unique user identifier
            ]
        ] as [String: Any]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error creating link token:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let linkToken = json["link_token"] as? String {
                    completion(linkToken)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error parsing link token response:", error)
                completion(nil)
            }
        }

        task.resume()
    }
    
    // returns a access token that can be used to fetch bank info
    func exchangePublicToken(publicToken: String, completion: @escaping (String?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        let url = URL(string: "https://\(environment).plaid.com/item/public_token/exchange")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "client_id": clientId,
            "secret": secret,
            "public_token": publicToken
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Error: unable to create JSON data from request body")
            return
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: missing response data")
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let accessToken = jsonResponse["access_token"] as? String {
                    print("\n\nAccess token: \(accessToken)\n\n")
                    // Store the access token securely and associate it with the user in your system
                    // Use the access token to fetch the user's bank information
                } else {
                    print("Error: unable to retrieve access token from response")
                }
            } catch {
                print("Error: unable to parse JSON response")
            }
        }

        task.resume()
    }
    
    func fetchAccountBalances(accessToken: String) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        let url = URL(string: "https://\(environment).plaid.com/accounts/balance/get")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "client_id": clientId,
            "secret": secret,
            "access_token": accessToken
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Error: unable to create JSON data from request body")
            return
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: missing response data")
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let accounts = jsonResponse["accounts"] as? [[String: Any]] {
                    for account in accounts {
                        if let name = account["name"] as? String,
                           let mask = account["mask"] as? String,
                           let balances = account["balances"] as? [String: Any],
                           let currentBalance = balances["current"] as? Double {
                            print("Account: \(name) (\(mask)), balance: \(currentBalance)")
                        }
                    }
                } else {
                    print("Error: unable to retrieve accounts from response")
                }
            } catch {
                print("Error: unable to parse JSON response")
            }
        }

        task.resume()
    }

    
    func fetchTransactionsForPastMonth(accessToken: String) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)


        let url = URL(string: "https://\(environment).plaid.com/transactions/get")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Use a date format string instead of a date
        let startDate = dateFormatter.string(from: Calendar.current.date(byAdding: .month, value: -1, to: Date())!)
        let endDate = dateFormatter.string(from: Date())
        
        print("\nStart DATE: \(startDate)\n")
        print("\nEND DATE: \(endDate)\n")

        let requestBody: [String: Any] = [
            "client_id": clientId,
            "secret": secret,
            "access_token": accessToken,
            "start_date": startDate,
            "end_date": endDate,
            "options": [
                "count": 100
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Error: unable to create JSON data from request body")
            return
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Error: missing response data")
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                if let transactions = jsonResponse["transactions"] as? [[String: Any]] {
                    print("TRANSACTIONS: \(jsonResponse)")
                    for transaction in transactions {
                        if let name = transaction["name"] as? String,
                           let amount = transaction["amount"] as? Double,
                           let date = transaction["date"] as? String {
                            print("\nTransaction: \(name), amount: \(amount), date: \(date)\n")
                        }
                    }
                } else {
                    print("Error: unable to retrieve transactions from response")
                }
            } catch {
                print("Error: unable to parse JSON response")
            }
        }

        task.resume()
    }

    
}
