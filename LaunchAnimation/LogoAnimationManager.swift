//
//  LogoAnimationManager.swift
//  LaunchAnimation
//
//  Created by Ulaş Sancak on 8.10.2024.
//

import Foundation
import SwiftUI

@Observable
class LogoAnimationManager {
    static let imageWH: CGFloat = 60
    var imageOffset: CGFloat = 0
    var isAnimating: Bool = false
    var didComplete: Bool = false
    
    func start() {
        isAnimating = true
        withAnimation(.easeInOut(duration: Constants.baseAnimationSpeed)) {
            self.imageOffset = -LogoAnimationManager.imageWH
        } completion: {
            withAnimation(.easeInOut(duration: Constants.baseAnimationSpeed)) {
                self.imageOffset = 0
                self.isAnimating = false
                self.didComplete = true
            }
        }
    }
    
    func reset(offset: CGFloat) {
        didComplete = false
        withAnimation {
            imageOffset = offset
        }
    }
}
