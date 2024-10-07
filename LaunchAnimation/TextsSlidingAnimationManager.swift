//
//  TextsSlidingAnimationManager.swift
//  LaunchAnimation
//
//  Created by Ulaş Sancak on 5.10.2024.
//

import Foundation
import SwiftUI

@Observable
class TextsSlidingAnimationManager {
    private static let initialSpacing: CGFloat = 8
    private static let spacingIncreaseConstant: CGFloat = 48
    private static let initialOffset: CGFloat = UIScreen.main.bounds.size.height/2 - 60
    private static let offsetDecreaseConstant: CGFloat = 300
    private static let loopCount = 10
    private static let animationSpeedPerIteration = 0.1
    
    private var currentIteration = 0

    var spacing: CGFloat = TextsSlidingAnimationManager.initialSpacing
    var offset = TextsSlidingAnimationManager.initialOffset
    
    var isAnimating: Bool = false
    var didComplete: Bool = false

    func start() {
        isAnimating = true
        withAnimation(.linear(duration: TextsSlidingAnimationManager.animationSpeedPerIteration)) {
            offset -= TextsSlidingAnimationManager.offsetDecreaseConstant * CGFloat(currentIteration)
            //Start gradually increase the spacing between texts
            if currentIteration > 2 {
                spacing += TextsSlidingAnimationManager.spacingIncreaseConstant
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + TextsSlidingAnimationManager.animationSpeedPerIteration) {
            self.currentIteration += 1
            if self.currentIteration >= TextsSlidingAnimationManager.loopCount {
                self.isAnimating = false
                self.didComplete = true
                return
            }
            self.start()
        }
    }
    
    func reset() {
        self.didComplete = false
        self.currentIteration = 0
        withAnimation {
            spacing = TextsSlidingAnimationManager.initialSpacing
            offset = TextsSlidingAnimationManager.initialOffset
        }
    }
}
