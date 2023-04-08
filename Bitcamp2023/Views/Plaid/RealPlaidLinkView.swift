//
//  RealPlaidLinkView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/8/23.
//

import SwiftUI
import LinkKit

struct RealPlaidLinkView: View {
    
    @EnvironmentObject var authViewModel: UserAuth
    
    @State private var showLink = false
    
    // save for each user
    private let linkToken = "link-development-c218d029-006a-42fa-baa9-8fef1660c2c5"
    
    var body: some View {
        VStack {
            Button {
                self.showLink = true
            } label: {
                ButtonDesign(buttonText: "Connect your account", buttonColor: .blue)
            }
            
            Button {
                
                PlaidRequest.shared.fetchTransactionsForPastMonth(accessToken: "access-sandbox-689477fc-a68a-430b-9c44-13ebd3519bbf")
                
            } label: {
                ButtonDesign(buttonText: "Get info", buttonColor: .blue)
            }
        }
        .sheet(isPresented: self.$showLink,
               onDismiss: {
            self.showLink = false
        }, content: {
            PlaidLinkFlow(
                linkTokenConfiguration: createLinkTokenConfiguration(),
                showLink: $showLink
            )
        }
        )
    }
    
    private func createLinkTokenConfiguration() -> LinkTokenConfiguration {
        var configuration = LinkTokenConfiguration(
            token: linkToken,
            onSuccess: { success in
                print("\n\npublic-token: \(success.publicToken)\nmetadata: \(success.metadata)\n\n")
                showLink = false
            }
        )
        
        configuration.onEvent = { event in
            print("Link Event: \(event)")
        }
        
        configuration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
            
            showLink = false
        }
        
        return configuration
    }
}

private struct PlaidLinkFlow: View {
    @Binding var showLink: Bool
    private let linkTokenConfiguration: LinkTokenConfiguration
    
    init(linkTokenConfiguration: LinkTokenConfiguration, showLink: Binding<Bool>) {
        self.linkTokenConfiguration = linkTokenConfiguration
        self._showLink = showLink
    }
    
    var body: some View {
        let linkController = LinkController(
            configuration: .linkToken(linkTokenConfiguration)
        ) { createError in
            print("Link Creation Error: \(createError)")
            self.showLink = false
        }
        
        return linkController
            .onOpenURL { url in
                linkController.linkHandler?.continue(from: url)
            }
    }
}
