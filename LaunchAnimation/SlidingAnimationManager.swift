//
//  SlidingAnimationManager.swift
//  LaunchAnimation
//
//  Created by Ulaş Sancak on 5.10.2024.
//

import Foundation
import SwiftUI

@Observable
class SlidingAnimationManager {
    private static let initialSpacing: CGFloat = 8
    private static let spacingIncreaseConstant: CGFloat = 48
    private static let initialOffset: CGFloat = UIScreen.main.bounds.size.height/2
    private static let offsetDecreaseConstant: CGFloat = 300
    private static let loopCount = 10
    private static let animationSpeedPerIteration = 0.1
    
    var spacing: CGFloat = SlidingAnimationManager.initialSpacing
    
    var offset = SlidingAnimationManager.initialOffset
    var isAnimating: Bool = false
    var currentIteration = 0

    func start() {
        isAnimating = true
        withAnimation(.linear(duration: SlidingAnimationManager.animationSpeedPerIteration)) {
            offset -= SlidingAnimationManager.offsetDecreaseConstant * CGFloat(currentIteration)
            //Start gradually increase the spacing between texts
            if currentIteration > 2 {
                spacing += SlidingAnimationManager.spacingIncreaseConstant
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + SlidingAnimationManager.animationSpeedPerIteration) {
            self.currentIteration += 1
            if self.currentIteration >= SlidingAnimationManager.loopCount {
                self.isAnimating = false
                return
            }
            self.start()
        }
    }
    
    func reset() {
        self.currentIteration = 0
        withAnimation {
            spacing = SlidingAnimationManager.initialSpacing
            offset = SlidingAnimationManager.initialOffset
        }
    }
}
