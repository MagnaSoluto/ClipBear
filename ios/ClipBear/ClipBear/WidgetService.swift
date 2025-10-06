import Foundation
import WidgetKit

class WidgetService {
    static let shared = WidgetService()
    
    private let appGroupIdentifier = "group.com.clipbear.mvp"
    
    private init() {}
    
    func updateWidget(with suggestion: String) {
        publishLatestSuggestionToWidget(suggestion)
    }
    
    /// Publish latest suggestion to widget via App Group
    /// - Parameter suggestion: The suggestion message to display in widget
    func publishLatestSuggestionToWidget(_ suggestion: String) {
        guard let sharedDefaults = UserDefaults(suiteName: appGroupIdentifier) else {
            print("⚠️ Failed to access App Group UserDefaults: \(appGroupIdentifier)")
            print("   Make sure App Group capability is enabled in Xcode")
            return
        }
        
        // Store suggestion in shared defaults
        sharedDefaults.set(suggestion, forKey: "latest_suggestion")
        sharedDefaults.set(Date().timeIntervalSince1970, forKey: "latest_suggestion_timestamp")
        sharedDefaults.synchronize()
        
        print("✅ Published suggestion to widget: \(suggestion)")
        
        // Reload widget timeline
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func clearWidget() {
        guard let sharedDefaults = UserDefaults(suiteName: appGroupIdentifier) else {
            print("Failed to access App Group UserDefaults")
            return
        }
        
        sharedDefaults.removeObject(forKey: "latest_suggestion")
        sharedDefaults.synchronize()
        
        // Reload widget timeline
        WidgetCenter.shared.reloadAllTimelines()
    }
}
