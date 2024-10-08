//
//  ContentView.swift
//  LaunchAnimation
//
//  Created by Ulaş Sancak on 5.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var textsSlidingAnimationManager = TextsSlidingAnimationManager()
    @State private var animationDataManager = AnimationDataManager()
    @State private var logoAnimationManager = LogoAnimationManager()
    @State private var viewHeight: CGFloat = 0
    @State private var geometryDidLoad: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: textsSlidingAnimationManager.spacing) {
                    ForEach(animationDataManager.texts) { text in
                        GradientLabel(text)
                    }
                }
                .offset(y: textsSlidingAnimationManager.offset)
                .frame(maxWidth: .infinity)
                ZStack(alignment: .center) {
                    getImage(geometry: geometry)
                        .offset(y: logoAnimationManager.imageOffset)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .onAppear {
                    print(geometry.size)
                }
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        animationDataManager.reset()
                        textsSlidingAnimationManager.reset()
                        logoAnimationManager.reset(offset: viewHeight/2 + LogoAnimationManager.imageWH/2)
                    }
                    .disabled(!animationDataManager.didComplete ||
                              textsSlidingAnimationManager.isAnimating ||
                              logoAnimationManager.isAnimating)
                }
            }
        }
        .onAppear {
            start()
        }
        .onChange(of: animationDataManager.didComplete) { _, newValue in
            if (newValue) {
                textsSlidingAnimationManager.start()
            }
        }
        .onChange(of: textsSlidingAnimationManager.didComplete) { _, newValue in
            if (newValue) {
                logoAnimationManager.start()
            }
        }
    }
    
    private func getImage(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            guard !geometryDidLoad, geometry.size.height > 0 else { return }
            logoAnimationManager.imageOffset = geometry.size.height/2 + LogoAnimationManager.imageWH/2
            viewHeight = geometry.size.height
            geometryDidLoad = true
        }
        return Image(.logo)
            .renderingMode(.template)
            .resizable()
            .frame(width: LogoAnimationManager.imageWH, height: LogoAnimationManager.imageWH)
            .foregroundStyle(.red)
    }
    
    private func start() {
        animationDataManager.start()
    }

}

#Preview {
    ContentView()
}
