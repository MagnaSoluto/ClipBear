import Foundation
import CoreData
import SwiftUI

@MainActor
class SettingsStore: ObservableObject {
    @Published var language: String = "en"
    @Published var intensity: String = "basic"
    @Published var snoozeUntil: Date = Date()
    @Published var overlayEnabled: Bool = false
    @Published var diagnosticsEnabled: Bool = false
    
    private let persistenceController = PersistenceController.shared
    private var context: NSManagedObjectContext {
        persistenceController.container.viewContext
    }
    
    init() {
        loadSettings()
    }
    
    private func loadSettings() {
        language = AppSettings.getValue(for: AppSettings.languageKey, in: context) ?? "en"
        intensity = AppSettings.getValue(for: AppSettings.intensityKey, in: context) ?? "basic"
        overlayEnabled = AppSettings.getValue(for: AppSettings.overlayEnabledKey, in: context) == "true"
        diagnosticsEnabled = AppSettings.getValue(for: AppSettings.diagnosticsEnabledKey, in: context) == "true"
        
        if let snoozeString = AppSettings.getValue(for: AppSettings.snoozeUntilKey, in: context),
           let snoozeTimestamp = Double(snoozeString) {
            snoozeUntil = Date(timeIntervalSince1970: snoozeTimestamp)
        }
    }
    
    func setLanguage(_ newLanguage: String) {
        language = newLanguage
        AppSettings.setValue(newLanguage, for: AppSettings.languageKey, in: context)
    }
    
    func setIntensity(_ newIntensity: String) {
        intensity = newIntensity
        AppSettings.setValue(newIntensity, for: AppSettings.intensityKey, in: context)
        
        // Notify UI of change
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func setSnoozeUntil(_ date: Date) {
        snoozeUntil = date
        let timestamp = String(date.timeIntervalSince1970)
        AppSettings.setValue(timestamp, for: AppSettings.snoozeUntilKey, in: context)
        
        // Notify UI of change
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func setOverlayEnabled(_ enabled: Bool) {
        overlayEnabled = enabled
        AppSettings.setValue(enabled ? "true" : "false", for: AppSettings.overlayEnabledKey, in: context)
        
        // Notify UI of change
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func setDiagnosticsEnabled(_ enabled: Bool) {
        diagnosticsEnabled = enabled
        AppSettings.setValue(enabled ? "true" : "false", for: AppSettings.diagnosticsEnabledKey, in: context)
        
        // Notify UI of change
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    var isSnoozed: Bool {
        return snoozeUntil > Date()
    }
    
    var maxSuggestionsPerDay: Int {
        return intensity == "proactive" ? 5 : 2 // Hard cap: basic=2, proactive=5
    }
    
    func clearSnooze() {
        setSnoozeUntil(Date())
    }
}
