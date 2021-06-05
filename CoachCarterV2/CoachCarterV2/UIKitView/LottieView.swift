//
//  LottieView.swift
//  CoachCarterV2
//
//  Created by Firat Ak on 05.06.21.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationView = AnimationView()
    var filename: String = ""
    var animate: LottieLoopMode
    
    func makeUIView(context: UIViewRepresentableContext <LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = animate
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext <LottieView>) {
        
    }
}
