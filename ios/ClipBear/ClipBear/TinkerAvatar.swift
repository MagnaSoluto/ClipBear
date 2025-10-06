import SwiftUI

struct TinkerAvatar: View {
    let state: AvatarState
    
    @State private var animationOffset: CGFloat = 0
    @State private var animationScale: CGFloat = 1.0
    @State private var animationRotation: Double = 0
    
    var body: some View {
        ZStack {
            // Main avatar circle with better contrast
            Circle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
                .scaleEffect(animationScale)
                .rotationEffect(.degrees(animationRotation))
                .offset(y: animationOffset)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
            
            // Avatar emoji
            Text("🤖")
                .font(.system(size: 24))
                .scaleEffect(animationScale)
                .rotationEffect(.degrees(animationRotation))
                .offset(y: animationOffset)
            
            // State indicator
            if state != .idle {
                Circle()
                    .fill(state == .suggest ? Color.orange : Color.green)
                    .frame(width: 8, height: 8)
                    .offset(x: 20, y: -20)
                    .opacity(state == .speak ? 0.5 : 1.0)
            }
        }
        .accessibilityLabel(accessibilityLabel)
        .onAppear {
            startAnimations()
        }
        .onChange(of: state) { _ in
            startAnimations()
        }
    }
    
    private var accessibilityLabel: String {
        let stateText = switch state {
        case .idle: "accessibility.tinker_idle".localized
        case .suggest: "accessibility.tinker_suggest".localized
        case .speak: "accessibility.tinker_speak".localized
        }
        return "accessibility.tinker_avatar".localized.replacingOccurrences(of: "%@", with: stateText)
    }
    
    private func startAnimations() {
        withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
            animationOffset = state == .idle ? 0 : 10
        }
        
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
            animationScale = state == .idle ? 1.0 : 1.05
        }
        
        if state == .suggest {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                animationRotation = 5
            }
        } else if state == .speak {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                animationRotation = 2
            }
        } else {
            animationRotation = 0
        }
    }
}

enum AvatarState {
    case idle
    case suggest
    case speak
}

