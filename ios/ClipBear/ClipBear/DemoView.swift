import SwiftUI

struct DemoView: View {
    let language: String
    let onDismiss: () -> Void
    
    @State private var selectedDemo: DemoType? = nil
    @State private var isProcessing = false
    @State private var showConfirmation = false
    @State private var confirmationMessage = ""
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.title2)
                }
                
                Spacer()
                
                Text(language == "pt" ? "Demos de Integração" : "Integration Demos")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Invisible button for balance
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .opacity(0)
                }
            }
            .padding(.horizontal, 24)
            
            // Demo Selection
            VStack(spacing: 16) {
                Text(language == "pt" ? 
                    "Escolha uma demonstração para experimentar:" :
                    "Choose a demonstration to try:")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                // Food Order Demo
                Button(action: {
                    selectedDemo = .foodOrder
                    showFoodOrderDemo()
                }) {
                    HStack {
                        Text("🍕")
                            .font(.title)
                        
                        VStack(alignment: .leading) {
                            Text(language == "pt" ? "Pedir Comida" : "Order Food")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(language == "pt" ? 
                                "Simule um pedido de comida" :
                                "Simulate a food order")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .disabled(isProcessing)
                
                // Table Booking Demo
                Button(action: {
                    selectedDemo = .tableBooking
                    showTableBookingDemo()
                }) {
                    HStack {
                        Text("🍽️")
                            .font(.title)
                        
                        VStack(alignment: .leading) {
                            Text(language == "pt" ? "Reservar Mesa" : "Book Table")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(language == "pt" ? 
                                "Simule uma reserva de mesa" :
                                "Simulate a table booking")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .disabled(isProcessing)
            }
            .padding(.horizontal, 24)
            
            // Confirmation Dialog
            if showConfirmation {
                VStack(spacing: 16) {
                    Text(language == "pt" ? "Confirmação" : "Confirmation")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(confirmationMessage)
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            showConfirmation = false
                            isProcessing = false
                        }) {
                            Text(language == "pt" ? "OK" : "OK")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(24)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(radius: 8)
                .padding(.horizontal, 24)
            }
            
            Spacer()
        }
        .padding(.vertical, 24)
    }
    
    private func showFoodOrderDemo() {
        isProcessing = true
        
        // Simulate processing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            confirmationMessage = language == "pt" ? 
                "🍕 Pedido de comida confirmado! (Demo - não é real)" :
                "🍕 Food order confirmed! (Demo - not real)"
            showConfirmation = true
        }
    }
    
    private func showTableBookingDemo() {
        isProcessing = true
        
        // Simulate processing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            confirmationMessage = language == "pt" ? 
                "🍽️ Mesa reservada com sucesso! (Demo - não é real)" :
                "🍽️ Table booked successfully! (Demo - not real)"
            showConfirmation = true
        }
    }
}

enum DemoType {
    case foodOrder
    case tableBooking
}

