////
////  PlaidLinkView.swift
////  Bitcamp2023
////
////  Created by Gerdin Ventura on 4/8/23.
////
//
//import SwiftUI
//import LinkKit
//
//
//struct PlaidLinkView: UIViewControllerRepresentable {
//    
//    @Environment(\.presentationMode) var presentationMode
//    var linkToken: String
//
//    class Coordinator: NSObject, PLKPlaidLinkViewDelegate {
//        var parent: PlaidLinkView
//
//        init(_ parent: PlaidLinkView) {
//            self.parent = parent
//        }
//
//        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken: String, metadata: [AnyHashable: Any]) {
//            // Handle success
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//
//        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didExitWithError error: Error?, metadata: [AnyHashable: Any]?) {
//            // Handle exit
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: Context) -> PLKPlaidLinkViewController {
//        let linkConfiguration = PLKConfiguration(linkToken: linkToken)
//        let linkViewController = PLKPlaidLinkViewController(configuration: linkConfiguration, delegate: context.coordinator)
//        return linkViewController
//    }
//
//    func updateUIViewController(_ uiViewController: PLKPlaidLinkViewController, context: Context) {}
//}
//
//
//struct PlaidLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaidLinkView()
//    }
//}
