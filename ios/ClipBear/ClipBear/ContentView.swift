import SwiftUI
import CoreData

struct ContentView: View {
    @State private var currentView = "onboarding"
    @State private var language = "en"
    @State private var overlayEnabled = false
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var settingsStore = SettingsStore()
    @State private var isCoreDataReady = false
    
    var body: some View {
        NavigationView {
            Group {
                switch currentView {
                case "onboarding":
                    OnboardingView(
                        language: $language,
                        onComplete: {
                            checkConsentAndNavigate()
                        }
                    )
                case "main":
                    MainView(
                        language: language,
                        overlayEnabled: $overlayEnabled,
                        onSettingsClick: {
                            currentView = "settings"
                        }
                    )
                case "settings":
                    SettingsView(
                        language: $language,
                        overlayEnabled: $overlayEnabled,
                        onBackClick: {
                            currentView = "main"
                        }
                    )
                default:
                    OnboardingView(
                        language: $language,
                        onComplete: {
                            currentView = "main"
                        }
                    )
                }
            }
        }
        .onAppear {
            loadSettings()
            // Wait for Core Data to be ready before checking consent
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                checkConsentAndNavigate()
            }
        }
    }
    
    private func loadSettings() {
        language = settingsStore.language
        overlayEnabled = settingsStore.overlayEnabled
    }
    
    private func checkConsentAndNavigate() {
        // Use the shared persistence controller
        let context = PersistenceController.shared.container.viewContext
        
        // Check if Core Data is ready
        guard context.persistentStoreCoordinator != nil else {
            print("Core Data not ready yet, defaulting to onboarding")
            currentView = "onboarding"
            return
        }
        
        // Check if user has given consent
        let request: NSFetchRequest<ConsentRecord> = ConsentRecord.fetchRequest()
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            let consents = try context.fetch(request)
            let currentPolicyVersion = "1.0" // Update this when policy changes
            
            if let consent = consents.first, consent.isValidForPolicy(currentPolicyVersion) {
                // Valid consent for current policy exists, go to main
                currentView = "main"
            } else {
                // No valid consent or needs re-consent, show onboarding
                currentView = "onboarding"
            }
        } catch {
            print("Error checking consent: \(error)")
            currentView = "onboarding"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

