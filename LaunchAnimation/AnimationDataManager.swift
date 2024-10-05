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
    var isReady: Bool = false
    var texts: [TextModel] = [.init(text: "CATCH")]
    
    func addTexts() {
        addInitialTexts()
    }
    
    func addInitialTexts() {
        let texts: [TextModel] = [.init(text: "YOUR"), .init(text: "CRUSH")]
        var delay: CGFloat = 0
        for (index, text) in texts.enumerated() {
            delay = CGFloat(index + 1) * 0.1 + CGFloat(index + 1) * 0.25
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.texts[0] = text
                if (index + 1) == texts.count {
                    self.addRemaining()
                }
            }
        }
    }
    
    func addRemaining() {
        let texts: [TextModel] = [TextModel].init(repeating: .init(text: "CRUSH", animationType: .opacity), count: 20)
        var delay: CGFloat = 0
        for (index, text) in texts.enumerated() {
            delay = CGFloat(index + 1) * 0.1 + 0.25
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.texts.append(text)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isReady = true
        }
    }
    
    func reset() {
        isReady = false
        withAnimation {
            texts = []
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.texts = [.init(text: "CATCH")]
            self.addInitialTexts()
        }
    }
}
