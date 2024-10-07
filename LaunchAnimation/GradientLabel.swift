//
//  GradientLabel.swift
//  LaunchAnimation
//
//  Created by Ulaş Sancak on 5.10.2024.
//

import SwiftUI

struct TextModel: Identifiable {
    let id: UUID = .init()
    let text: String
    let animationType: AnimationType
    
    init(text: String, animationType: AnimationType = .scale) {
        self.text = text
        self.animationType = animationType
    }
}

enum AnimationType {
    case scale
    case opacity
}

struct GradientLabel: View {
    private static let scaleForAnimation: CGFloat = 1.5
    private static let opacityForAnimation: CGFloat = 0
    
    private let text: TextModel
    
    @State private var isAnimating: Bool = false
    @State private var scale: Double
    @State private var opacity: Double

    init(_ text: TextModel) {
        self.text = text
        switch text.animationType {
        case .scale:
            _opacity = State(initialValue: 1.0)
            _scale = State(initialValue: GradientLabel.scaleForAnimation)
        case .opacity:
            _opacity = State(initialValue: GradientLabel.opacityForAnimation)
            _scale = State(initialValue: 1.0)
        }
    }
    
    private var animationValue: Double {
        switch text.animationType {
        case .scale:
            return scale
        case .opacity:
            return opacity
        }
    }
    
    var body: some View {
        Text(text.text)
        .foregroundStyle(
            LinearGradient(
                colors: [.textGradient0, .textGradient1],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .font(.system(size: 72))
        .bold()
        .padding()
        .scaleEffect(scale)
        .opacity(opacity)
        .animation(.easeIn(duration: Constants.baseAnimationSpeed), value: animationValue)
        .onAppear {
            switch text.animationType {
            case .scale:
                scale = 1.0
            case .opacity:
                opacity = 1.0
            }
        }
    }
}

#Preview {
    VStack {
        GradientLabel(.init(text: "CATCH"))
        GradientLabel(.init(text: "YOUR"))
        GradientLabel(.init(text: "CRUSH"))
        GradientLabel(.init(text: "CRUSH", animationType: .opacity))
        GradientLabel(.init(text: "CRUSH", animationType: .opacity))
        GradientLabel(.init(text: "CRUSH", animationType: .opacity))
        GradientLabel(.init(text: "CRUSH", animationType: .opacity))
        GradientLabel(.init(text: "CRUSH", animationType: .opacity))
    }
}
