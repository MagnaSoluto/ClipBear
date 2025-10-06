import SwiftUI
import CoreData

struct OnboardingView: View {
    @Binding var language: String
    let onComplete: () -> Void
    
    @State private var currentStep = 0
    @State private var consentGiven = false
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var localizationManager = LocalizationManager.shared
    
    private let steps = ["welcome", "privacy", "permissions", "complete"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 32) {
                // Tinker Avatar
                TinkerAvatar(state: .speak)
                    .frame(width: min(120, geometry.size.width * 0.3), height: min(120, geometry.size.width * 0.3))
                
                // Step content
                Group {
                    switch steps[currentStep] {
                    case "welcome":
                        WelcomeStep(language: language, onLanguageChange: { language = $0 })
                    case "privacy":
                        PrivacyStep(language: language)
                    case "permissions":
                        PermissionsStep(language: language)
                    case "complete":
                        CompleteStep(
                            language: language,
                            consentGiven: $consentGiven
                        )
                    default:
                        WelcomeStep(language: language, onLanguageChange: { language = $0 })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, min(24, geometry.size.width * 0.05))
                
                Spacer()
                
                // Navigation buttons
                HStack {
                    if currentStep > 0 {
                        Button(action: { currentStep -= 1 }) {
                            Text("button.back".localized)
                                .foregroundColor(.secondary)
                        }
                        .accessibilityLabel("accessibility.back_button".localized)
                        .accessibilityHint("Go to previous onboarding step")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("🔘 Button tapped - currentStep: \(currentStep), steps.count: \(steps.count)")
                        if currentStep < steps.count - 1 {
                            print("➡️ Moving to next step")
                            currentStep += 1
                        } else {
                            print("✅ Completing onboarding")
                            saveConsentAndComplete()
                        }
                    }) {
                        Text(
                            currentStep < steps.count - 1 ?
                            "button.next".localized :
                            "button.get_started".localized
                        )
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .disabled(currentStep == steps.count - 1 && !consentGiven)
                    .accessibilityLabel(currentStep < steps.count - 1 ? "button.next".localized : "button.get_started".localized)
                    .accessibilityHint(currentStep < steps.count - 1 ? "Continue to next step" : "Complete onboarding and start using ClipBear")
                }
                .padding(.horizontal, min(24, geometry.size.width * 0.05))
            }
            .padding(.vertical, 40)
        }
        .onAppear {
            // Sync language with LocalizationManager
            localizationManager.setLanguage(language)
        }
        .onChange(of: language) { newLanguage in
            // Update LocalizationManager when language changes
            localizationManager.setLanguage(newLanguage)
        }
    }
    
    private func saveConsentAndComplete() {
        print("💾 Starting saveConsentAndComplete...")
        
        // Save consent record using the shared persistence controller
        let context = PersistenceController.shared.container.viewContext
        
        print("📝 Creating consent record...")
        guard ConsentRecord.create(
            scopes: ["usage_stats", "notifications", "widgets", "app_intents"],
            language: language,
            version: "1.0",
            in: context
        ) != nil else {
            print("❌ Failed to create consent record")
            // Still proceed to avoid blocking user
            print("🚀 Calling onComplete() anyway...")
            onComplete()
            return
        }
        
        do {
            try context.save()
            print("✅ Consent saved successfully")
            print("🚀 Calling onComplete()...")
            onComplete()
        } catch {
            print("❌ Error saving consent: \(error)")
            // Still proceed to avoid blocking user
            print("🚀 Calling onComplete() anyway...")
            onComplete()
        }
    }
}

struct WelcomeStep: View {
    let language: String
    let onLanguageChange: (String) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("onboarding.welcome.title".localized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("onboarding.welcome.subtitle".localized)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            VStack(spacing: 8) {
                Text("language.title".localized)
                    .font(.headline)
                
                HStack(spacing: 16) {
                    Button(action: { onLanguageChange("en") }) {
                        Text("language.english".localized)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(language == "en" ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(language == "en" ? .white : .primary)
                            .cornerRadius(8)
                    }
                    .accessibilityLabel("accessibility.language_button".localized.replacingOccurrences(of: "%@", with: "English"))
                    
                    Button(action: { onLanguageChange("pt") }) {
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
        }
    }
}

struct PrivacyStep: View {
    let language: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text("onboarding.privacy.title".localized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("onboarding.privacy.content".localized)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct PermissionsStep: View {
    let language: String
    @State private var permissionGranted: Bool? = nil
    @State private var isRequesting = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("onboarding.permissions.title".localized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("onboarding.permissions.content".localized)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            
            // Request notification permission button
            Button(action: {
                requestNotificationPermission()
            }) {
                HStack {
                    if isRequesting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else if let granted = permissionGranted {
                        Image(systemName: granted ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(granted ? .green : .red)
                    } else {
                        Image(systemName: "bell.badge")
                    }
                    
                    Text(permissionButtonText)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(permissionGranted == nil ? 1.0 : 0.5))
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .disabled(isRequesting || permissionGranted != nil)
            .accessibilityLabel("Request Notification Permission")
        }
    }
    
    private var permissionButtonText: String {
        if isRequesting {
            return "Requesting..."
        } else if let granted = permissionGranted {
            return granted ? "Permission Granted ✓" : "Permission Denied"
        } else {
            return "Enable Notifications"
        }
    }
    
    private func requestNotificationPermission() {
        isRequesting = true
        Task {
            let granted = await NotificationService.shared.requestPermission()
            await MainActor.run {
                permissionGranted = granted
                isRequesting = false
            }
        }
    }
}

struct CompleteStep: View {
    let language: String
    @Binding var consentGiven: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Text("onboarding.complete.title".localized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("onboarding.complete.content".localized)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            HStack {
                Button(action: { consentGiven.toggle() }) {
                    Image(systemName: consentGiven ? "checkmark.square.fill" : "square")
                        .foregroundColor(consentGiven ? .blue : .gray)
                        .font(.title2)
                }
                .accessibilityLabel(consentGiven ? "Uncheck consent" : "Check consent")
                
                Text("I Accept")
                    .font(.body)
            }
        }
    }
}

