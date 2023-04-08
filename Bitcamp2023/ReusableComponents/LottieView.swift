//
//  LottieView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/8/23.
//

import Foundation
import SwiftUI
import Lottie


struct LottieView: UIViewRepresentable {
    //    var name = "account_created.json"
    var name = "credit.json"
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: name)
        view.loopMode = .loop
        view.play()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

