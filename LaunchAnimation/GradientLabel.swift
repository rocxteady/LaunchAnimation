//
//  GradientLabel.swift
//  LaunchAnimation
//
//  Created by Ulaş Sancak on 5.10.2024.
//

import SwiftUI

struct GradientLabel: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            Text(text)
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
        }
    }
}

#Preview {
    GradientLabel("CATCH")
}
