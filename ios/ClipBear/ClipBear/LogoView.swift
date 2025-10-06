import SwiftUI

struct LogoView: View {
    let size: CGFloat
    let showText: Bool
    
    init(size: CGFloat = 40, showText: Bool = true) {
        self.size = size
        self.showText = showText
    }
    
    var body: some View {
        HStack(spacing: 8) {
            // Logo icon with gradient
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue,
                                Color.purple,
                                Color.pink
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                
                Image(systemName: "applelogo")
                    .font(.system(size: size * 0.5, weight: .bold))
                    .foregroundColor(.white)
            }
            
            if showText {
                VStack(alignment: .leading, spacing: 2) {
                    Text("TechStore")
                        .font(.system(size: size * 0.4, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Premium")
                        .font(.system(size: size * 0.25, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                }
            }
        }
    }
}

struct AnimatedLogoView: View {
    @State private var isAnimating = false
    let size: CGFloat
    let showText: Bool
    
    init(size: CGFloat = 40, showText: Bool = true) {
        self.size = size
        self.showText = showText
    }
    
    var body: some View {
        HStack(spacing: 8) {
            // Animated logo icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue,
                                Color.purple,
                                Color.pink
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: isAnimating)
                
                Image(systemName: "applelogo")
                    .font(.system(size: size * 0.5, weight: .bold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(.linear(duration: 4.0).repeatForever(autoreverses: false), value: isAnimating)
            }
            
            if showText {
                VStack(alignment: .leading, spacing: 2) {
                    Text("TechStore")
                        .font(.system(size: size * 0.4, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 0.8 : 1.0)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                    
                    Text("Premium")
                        .font(.system(size: size * 0.25, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(isAnimating ? 1.0 : 0.6)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true).delay(0.5), value: isAnimating)
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        LogoView(size: 50)
        AnimatedLogoView(size: 50)
        LogoView(size: 30, showText: false)
    }
    .padding()
    .background(Color.gray)
}

