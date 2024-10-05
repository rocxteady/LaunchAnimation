//
//  ContentView.swift
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

struct ContentView: View {
    @State private var animator = SlidingAnimationManager()
    @State var animationDataManager = AnimationDataManager()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: animator.spacing) {
                    ForEach(animationDataManager.texts) { text in
                        GradientLabel(text)
                    }
                }
                .offset(y: animator.offset)
                .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea()
            .onAppear {
                addInitialTexts()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        animationDataManager.reset()
                        animator.reset()
                    }
                    .disabled(animator.isAnimating)
                }
            }
        }
        .onChange(of: animationDataManager.isReady) { oldValue, newValue in
            if (newValue) {
                animator.start()
            }
        }
    }
    
    private func addInitialTexts() {
        animationDataManager.addInitialTexts()
    }
}

#Preview {
    ContentView()
}
