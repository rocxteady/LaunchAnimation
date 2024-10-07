//
//  AnimationDataManager.swift
//  LaunchAnimation
//
//  Created by Ulaş Sancak on 5.10.2024.
//

import Foundation
import SwiftUI

@Observable
class AnimationDataManager {
    private static let animationDelayBetweenTexts: CGFloat = 0.25
    private static let textCountAfterInitialAnimation: Int = 19
    private static let animatedTextCount: Int = 10
    
    var didComplete: Bool = false
    var texts: [TextModel] = [.init(text: "CATCH")]
    
    func start() {
        addInitialTexts()
    }
    
    func reset() {
        didComplete = false
        withAnimation {
            texts = []
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.texts = [.init(text: "CATCH")]
            self.start()
        }
    }
    
    private func addInitialTexts() {
        let texts: [TextModel] = [.init(text: "YOUR"), .init(text: "CRUSH")]
        var delay: CGFloat = 0
        for (index, text) in texts.enumerated() {
            delay = CGFloat(index + 1) * Constants.baseAnimationSpeed + CGFloat(index + 1) * AnimationDataManager.animationDelayBetweenTexts
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.texts[0] = text
                if (index + 1) == texts.count {
                    self.addRemaining()
                }
            }
        }
    }
    
    private func addRemaining() {
        let texts: [TextModel] = Array(repeating: (), count: AnimationDataManager.textCountAfterInitialAnimation).map { _ in TextModel(text: "CRUSH", animationType: .opacity) }
        var delay: CGFloat = 0
        let duration = CGFloat(AnimationDataManager.animatedTextCount) * Constants.baseAnimationSpeed + AnimationDataManager.animationDelayBetweenTexts
        for (index, text) in texts.enumerated() {
            delay = CGFloat(min(index, AnimationDataManager.animatedTextCount) + 1) * Constants.baseAnimationSpeed + AnimationDataManager.animationDelayBetweenTexts
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.texts.append(text)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.didComplete = true
        }
    }
}
