import SwiftUI
import CoreData

struct SettingsView: View {
    @Binding var language: String
    @Binding var overlayEnabled: Bool
    let onBackClick: () -> Void
    
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var dataExportService = DataExportService.shared
    @State private var showingExportSheet = false
    @State private var showingDeleteAlert = false
    @State private var showingDeleteConfirmation = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 24) {
                // Header
                HStack {
                    Button(action: onBackClick) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                    }
                    .accessibilityLabel("accessibility.back_button".localized)
                    
                    Spacer()
                    
                    Text(language == "pt" ? "Configurações" : "Settings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Invisible button for balance
                    Button(action: {}) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .opacity(0)
                    }
                }
                .padding(.horizontal, min(24, geometry.size.width * 0.05))
                
                ScrollView {
                    VStack(spacing: 16) {
                    // Language Setting
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Idioma" : "Language")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                HStack(spacing: 16) {
                    Button(action: { 
                        language = "en"
                        settingsStore.setLanguage("en")
                    }) {
                        Text("language.english".localized)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(language == "en" ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(language == "en" ? .white : .primary)
                            .cornerRadius(8)
                    }
                    .accessibilityLabel("accessibility.language_button".localized.replacingOccurrences(of: "%@", with: "English"))
                    
                    Button(action: { 
                        language = "pt"
                        settingsStore.setLanguage("pt")
                    }) {
                        Text("language.portuguese".localized)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(language == "pt" ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(language == "pt" ? .white : .primary)
                            .cornerRadius(8)
                    }
                    .accessibilityLabel("accessibility.language_button".localized.replacingOccurrences(of: "%@", with: "Português"))
                }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Intensity Setting
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Intensidade de Sugestões" : "Suggestion Intensity")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(language == "pt" ? 
                            "Com que frequência o Tinker deve fazer sugestões?" :
                            "How often should Tinker make suggestions?")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 16) {
                            Button(action: { settingsStore.setIntensity("basic") }) {
                                Text(language == "pt" ? "Básico (1-2/dia)" : "Basic (1-2/day)")
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(settingsStore.intensity == "basic" ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(settingsStore.intensity == "basic" ? .white : .primary)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: { settingsStore.setIntensity("proactive") }) {
                                Text(language == "pt" ? "Proativo (até 5/dia)" : "Proactive (up to 5/day)")
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(settingsStore.intensity == "proactive" ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(settingsStore.intensity == "proactive" ? .white : .primary)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Snooze Setting
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Adiar Sugestões" : "Snooze Suggestions")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(language == "pt" ? 
                            "Pausar sugestões temporariamente" :
                            "Temporarily pause suggestions")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 8) {
                            Button(action: { 
                                settingsStore.setSnoozeUntil(Date().addingTimeInterval(60 * 60)) // 1 hour
                            }) {
                                Text(language == "pt" ? "1 Hora" : "1 Hour")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(.primary)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: { 
                                settingsStore.setSnoozeUntil(Date().addingTimeInterval(24 * 60 * 60)) // 24 hours
                            }) {
                                Text(language == "pt" ? "24 Horas" : "24 Hours")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(.primary)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: { 
                                settingsStore.setSnoozeUntil(Date()) // Cancel snooze
                            }) {
                                Text(language == "pt" ? "Cancelar" : "Cancel")
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Diagnostics Setting
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Diagnósticos" : "Diagnostics")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(language == "pt" ? 
                            "Habilitar logs locais para debug (dados ficam no dispositivo)" :
                            "Enable local logging for debugging (data stays on device)")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        Toggle("", isOn: $settingsStore.diagnosticsEnabled)
                            .labelsHidden()
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Data Management
                    VStack(spacing: 16) {
                        HStack {
                            Text(language == "pt" ? "Gerenciamento de Dados" : "Data Management")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text(language == "pt" ? 
                            "Gerencie seus dados e privacidade" :
                            "Manage your data and privacy")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 8) {
                            Button(action: { 
                                _ = dataExportService.exportAllData()
                                showingExportSheet = true
                            }) {
                                Text("settings.export_data".localized)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("accessibility.export_button".localized)
                            
                            Button(action: { 
                                showingDeleteAlert = true
                            }) {
                                Text("settings.delete_all_data".localized)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .accessibilityLabel("accessibility.delete_button".localized)
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    }
                    .padding(.horizontal, min(24, geometry.size.width * 0.05))
                }
            }
            .padding(.vertical, 24)
        }
        .sheet(isPresented: $showingExportSheet) {
            if let exportURL = dataExportService.exportedURL {
                ShareSheet(activityItems: [exportURL])
            }
        }
        .alert("Delete All Data", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                showingDeleteConfirmation = true
            }
        } message: {
            Text("This will permanently delete all your data. This action cannot be undone.")
        }
        .alert("Confirm Deletion", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete Everything", role: .destructive) {
                dataExportService.deleteAllData()
            }
        } message: {
            Text("Are you absolutely sure? This will delete all settings, suggestions, and feedback data.")
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

