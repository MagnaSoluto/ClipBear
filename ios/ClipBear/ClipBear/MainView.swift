import SwiftUI
import CoreData

struct MainView: View {
    let language: String
    @Binding var overlayEnabled: Bool
    let onSettingsClick: () -> Void
    
    @State private var latestSuggestion: Suggestion?
    @State private var suggestionCount = 0
    @State private var showiPhoneAd = false
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var notificationService = NotificationService.shared
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    HStack {
                        Text("ClipBear")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: onSettingsClick) {
                            Image(systemName: "gearshape")
                                .font(.title2)
                        }
                        .accessibilityLabel("accessibility.settings_button".localized)
                    }
                    .padding(.horizontal, min(24, geometry.size.width * 0.05))
            
                    // Tinker Avatar
                    TinkerAvatar(state: .idle)
                        .frame(width: min(120, geometry.size.width * 0.3), height: min(120, geometry.size.width * 0.3))
                    
                    // Status Card
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Status" : "Status")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        HStack {
                            Text(language == "pt" ? "Overlay:" : "Overlay:")
                            Spacer()
                            Text(overlayEnabled ? 
                                (language == "pt" ? "Habilitado" : "Enabled") : 
                                (language == "pt" ? "Desabilitado" : "Disabled"))
                                .foregroundColor(overlayEnabled ? .blue : .secondary)
                        }
                        
                        HStack {
                            Text(language == "pt" ? "Sugestões hoje:" : "Suggestions today:")
                            Spacer()
                            Text("\(suggestionCount)")
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal, min(24, geometry.size.width * 0.05))
            
                    // Latest Suggestion Card
                    if let suggestion = latestSuggestion {
                        VStack(spacing: 16) {
                            HStack {
                                Text("main.latest_suggestion".localized)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            
                            Text("main.tinker_says".localized)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text(suggestion.message)
                                .font(.body)
                            
                            // Explainability - CRITICAL for MVP
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Why?")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                
                                Text(suggestion.explanation)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(8)
                                    .accessibilityLabel("accessibility.suggestion_explanation".localized.replacingOccurrences(of: "%@", with: suggestion.explanation))
                            }
                            
                            HStack(spacing: 16) {
                                Button(action: { handleSuggestionFeedback(suggestion, accepted: true) }) {
                                    Text("feedback.accept".localized)
                                        .font(.title2)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("accessibility.feedback_accept".localized)
                                
                                Button(action: { handleSuggestionFeedback(suggestion, accepted: false) }) {
                                    Text("feedback.reject".localized)
                                        .font(.title2)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .accessibilityLabel("accessibility.feedback_reject".localized)
                            }
                        }
                        .padding(16)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal, min(24, geometry.size.width * 0.05))
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("accessibility.suggestion_card".localized.replacingOccurrences(of: "%@", with: suggestion.message))
                    }
            
                    // Overlay Toggle
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Controle de Overlay" : "Overlay Control")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(language == "pt" ? 
                            "Habilitar a bolha do companheiro flutuante" :
                            "Enable the floating companion bubble")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        Toggle("", isOn: $overlayEnabled)
                            .labelsHidden()
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal, min(24, geometry.size.width * 0.05))
            
                    // Demo Actions
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Ações de Demo" : "Demo Actions")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(language == "pt" ? 
                            "Experimente integrações falsas" :
                            "Try out fake integrations")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 16) {
                            Button(action: { /* Handle food order demo */ }) {
                                Text(language == "pt" ? "🍕 Pedir Comida" : "🍕 Order Food")
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: { /* Handle table booking demo */ }) {
                                Text(language == "pt" ? "🍽️ Reservar Mesa" : "🍽️ Book Table")
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        
                        // iPhone Ad Button
                        Button(action: { showiPhoneAd = true }) {
                            HStack(spacing: 8) {
                                Image(systemName: "iphone")
                                    .font(.title2)
                                Text(language == "pt" ? "📱 Ver Anúncio iPhone" : "📱 View iPhone Ad")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.orange, Color.red]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(color: .orange.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .padding(.top, 8)
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal, min(24, geometry.size.width * 0.05))
                    
                    Spacer(minLength: 20)
                }
                .padding(.vertical, 24)
            }
        }
        .onAppear {
            loadLatestSuggestion()
            loadSuggestionCount()
        }
        .sheet(isPresented: $showiPhoneAd) {
            // iPhone Ad View - será implementado quando os arquivos forem adicionados ao projeto
            VStack {
                Text("iPhone Ad View")
                    .font(.largeTitle)
                    .padding()
                
                Text("Esta funcionalidade será implementada em breve")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()
                
                Button("Fechar") {
                    showiPhoneAd = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
    }
    
    private func loadLatestSuggestion() {
        let request: NSFetchRequest<Suggestion> = Suggestion.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Suggestion.timestamp, ascending: false)]
        request.fetchLimit = 1
        
        do {
            let suggestions = try viewContext.fetch(request)
            latestSuggestion = suggestions.first
        } catch {
            print("Error loading latest suggestion: \(error)")
        }
    }
    
    private func loadSuggestionCount() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        
        let request: NSFetchRequest<Suggestion> = Suggestion.fetchRequest()
        request.predicate = NSPredicate(format: "timestamp >= %@", startOfDay as NSDate)
        
        do {
            let suggestions = try viewContext.fetch(request)
            suggestionCount = suggestions.count
        } catch {
            print("Error loading suggestion count: \(error)")
        }
    }
    
    private func handleSuggestionFeedback(_ suggestion: Suggestion, accepted: Bool) {
        // Mark suggestion as accepted/rejected
        if accepted {
            suggestion.markAsAccepted()
        } else {
            suggestion.markAsRejected()
        }
        
        // Save feedback
        _ = SuggestionFeedback.create(
            ruleId: suggestion.ruleId,
            accepted: accepted,
            sessionId: suggestion.sessionId,
            in: viewContext
        )
        
        do {
            try viewContext.save()
            
            // Clear latest suggestion after feedback
            latestSuggestion = nil
            loadSuggestionCount()
        } catch {
            print("Error saving feedback: \(error)")
        }
    }
}

