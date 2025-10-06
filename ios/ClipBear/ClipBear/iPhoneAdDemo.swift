import SwiftUI

struct iPhoneAdDemo: View {
    @State private var showAd = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 16) {
                AnimatedLogoView(size: 60, showText: true)
                
                Text("Demonstração do Anúncio iPhone")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Toque no botão abaixo para ver o anúncio interativo do iPhone 11 Pro Max")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 24)
            
            // Demo button
            Button(action: { showAd = true }) {
                HStack(spacing: 12) {
                    Image(systemName: "iphone")
                        .font(.title)
                    
                    VStack(spacing: 4) {
                        Text("Ver Anúncio")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("Interface moderna e interativa")
                            .font(.caption)
                            .opacity(0.8)
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(25)
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            
            // Features preview
            VStack(alignment: .leading, spacing: 16) {
                Text("Características do Anúncio:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 8) {
                    FeaturePreview(icon: "paintbrush.fill", text: "Design moderno e profissional")
                    FeaturePreview(icon: "iphone", text: "Mockups 3D dos iPhones")
                    FeaturePreview(icon: "sparkles", text: "Animações suaves e elegantes")
                    FeaturePreview(icon: "message.fill", text: "Integração com WhatsApp")
                    FeaturePreview(icon: "cart.fill", text: "Botão de compra chamativo")
                    FeaturePreview(icon: "gear", text: "Seleção de armazenamento")
                }
            }
            .padding(20)
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .padding(.vertical, 40)
        .sheet(isPresented: $showAd) {
            iPhoneAdView()
        }
    }
}

struct FeaturePreview: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.blue)
                .frame(width: 16)
            
            Text(text)
                .font(.caption)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    iPhoneAdDemo()
}

