import SwiftUI

struct iPhoneAdView: View {
    @State private var selectedStorage: StorageOption = .gb64
    @State private var showColorInfo = false
    @State private var animatePhones = false
    @State private var showFeatures = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.36, green: 0.38, blue: 0.37),
                    Color(red: 0.28, green: 0.30, blue: 0.29)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with logo
                HStack {
                    // Close button
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    // Animated logo
                    AnimatedLogoView(size: 35, showText: true)
                    
                    Spacer()
                    
                    // WhatsApp contact button
                    Button(action: {
                        // Ação para abrir WhatsApp
                        if let url = URL(string: "https://wa.me/5511999999999") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "message.fill")
                                .font(.caption)
                            Text("WhatsApp")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                // Main content
                HStack(spacing: 0) {
                    // Left side - iPhone images
                    VStack {
                        // iPhone showcase
                        ZStack {
                            // Background circle for depth
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [
                                            Color.white.opacity(0.1),
                                            Color.clear
                                        ]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: 120
                                    )
                                )
                                .frame(width: 240, height: 240)
                            
                            // iPhone mockups
                            HStack(spacing: -20) {
                                // Gold iPhone
                                iPhoneMockup(color: .yellow, isFront: false)
                                    .offset(y: animatePhones ? -5 : 0)
                                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true).delay(0.0), value: animatePhones)
                                
                                // Midnight Green iPhone
                                iPhoneMockup(color: .green, isFront: false)
                                    .offset(y: animatePhones ? -3 : 0)
                                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true).delay(0.5), value: animatePhones)
                                
                                // Silver iPhone
                                iPhoneMockup(color: .white, isFront: false)
                                    .offset(y: animatePhones ? -4 : 0)
                                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true).delay(1.0), value: animatePhones)
                                
                                // Space Gray iPhone (front view)
                                iPhoneMockup(color: .gray, isFront: true)
                                    .offset(y: animatePhones ? -2 : 0)
                                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true).delay(1.5), value: animatePhones)
                            }
                        }
                        .frame(height: 200)
                        
                        // Color availability text
                        Text("Verifique a disponibilidade de cores com o vendedor no WhatsApp")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.4)
                    
                    // Right side - Product info
                    VStack(alignment: .leading, spacing: 20) {
                        // Product title
                        VStack(alignment: .leading, spacing: 8) {
                            Text("IPHONE 11 PRO MAX")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            
                            Text("SEMINOVO")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        
                        // Price and storage
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(selectedStorage == .gb64 ? "R$ 2.999,00" : "R$ 3.499,00")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.91, green: 0.66, blue: 0.24))
                                    .animation(.easeInOut(duration: 0.3), value: selectedStorage)
                                
                                Text(selectedStorage.displayName)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .animation(.easeInOut(duration: 0.3), value: selectedStorage)
                                
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                    .scaleEffect(animatePhones ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: animatePhones)
                            }
                            
                            Text("Escolha a melhor opção para você:")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        
                        // Storage options
                        HStack(spacing: 16) {
                            StorageButton(
                                storage: .gb64,
                                isSelected: selectedStorage == .gb64,
                                action: { selectedStorage = .gb64 }
                            )
                            
                            StorageButton(
                                storage: .gb256,
                                isSelected: selectedStorage == .gb256,
                                action: { selectedStorage = .gb256 }
                            )
                        }
                        
                        // Features list
                        VStack(alignment: .leading, spacing: 8) {
                            FeatureRow(icon: "camera.fill", text: "Sistema de câmera tripla", delay: 0.0)
                            FeatureRow(icon: "battery.100", text: "Bateria de longa duração", delay: 0.2)
                            FeatureRow(icon: "water.waves", text: "Resistente à água", delay: 0.4)
                            FeatureRow(icon: "faceid", text: "Face ID", delay: 0.6)
                        }
                        .padding(.top, 20)
                        .opacity(showFeatures ? 1 : 0)
                        .offset(y: showFeatures ? 0 : 20)
                        
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .padding(.leading, 20)
                }
                .padding(.top, 30)
                
                // Call to action button
                VStack(spacing: 16) {
                    Button(action: {
                        // Ação para comprar
                        if let url = URL(string: "https://wa.me/5511999999999?text=Olá! Gostaria de saber mais sobre o iPhone 11 Pro Max \(selectedStorage.displayName)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "cart.fill")
                                .font(.title2)
                            
                            VStack(spacing: 2) {
                                Text("COMPRAR AGORA")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text("Entre em contato via WhatsApp")
                                    .font(.caption)
                                    .opacity(0.9)
                            }
                            
                            Image(systemName: "arrow.right")
                                .font(.title3)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.green,
                                    Color.blue
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                        .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .scaleEffect(animatePhones ? 1.0 : 0.95)
                    .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: animatePhones)
                    
                    Text("✨ Garantia de 90 dias • Entrega rápida • Suporte 24/7")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                animatePhones = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    showFeatures = true
                }
            }
        }
    }
}

struct iPhoneMockup: View {
    let color: Color
    let isFront: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(color)
            .frame(width: 60, height: 120)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .overlay(
                // Screen content
                VStack {
                    if isFront {
                        // Front view - screen
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.black,
                                        Color.blue.opacity(0.3)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 50, height: 100)
                            .overlay(
                                // Camera notch
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.black)
                                    .frame(width: 20, height: 6)
                                    .offset(y: -40)
                            )
                    } else {
                        // Back view - camera system
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 8, height: 8)
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 8, height: 8)
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 8, height: 8)
                            }
                            .offset(y: -20)
                            
                            // Apple logo
                            Image(systemName: "applelogo")
                                .font(.caption2)
                                .foregroundColor(.black.opacity(0.6))
                                .offset(y: 10)
                        }
                    }
                }
            )
            .rotationEffect(.degrees(isFront ? 0 : 15))
            .scaleEffect(isFront ? 1.0 : 0.9)
    }
}

struct StorageButton: View {
    let storage: StorageOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(storage.displayName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Image(systemName: "applelogo")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                isSelected ? 
                Color(red: 0.91, green: 0.66, blue: 0.24) :
                Color.white.opacity(0.2)
            )
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(
                        isSelected ? 
                        Color.clear :
                        Color.white.opacity(0.3),
                        lineWidth: 1
                    )
            )
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    let delay: Double
    @State private var isVisible = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(Color(red: 0.91, green: 0.66, blue: 0.24))
                .frame(width: 16)
                .scaleEffect(isVisible ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 0.4).delay(delay), value: isVisible)
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .opacity(isVisible ? 1 : 0)
                .offset(x: isVisible ? 0 : -20)
                .animation(.easeInOut(duration: 0.4).delay(delay), value: isVisible)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    isVisible = true
                }
            }
        }
    }
}

enum StorageOption {
    case gb64
    case gb256
    
    var displayName: String {
        switch self {
        case .gb64:
            return "64GB"
        case .gb256:
            return "256GB"
        }
    }
}

#Preview {
    iPhoneAdView()
}
