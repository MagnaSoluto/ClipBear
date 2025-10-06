import Foundation

class LocalizationManager: ObservableObject {
    @Published var currentLanguage: String = "en"
    
    static let shared = LocalizationManager()
    
    private var currentBundle: Bundle = Bundle.main
    private let appGroupIdentifier = "group.com.clipbear.mvp"
    
    private init() {
        // Load saved language from UserDefaults
        currentLanguage = UserDefaults.standard.string(forKey: "selected_language") ?? Locale.current.languageCode ?? "en"
        loadBundleForLanguage(currentLanguage)
    }
    
    func setLanguage(_ language: String) {
        currentLanguage = language
        UserDefaults.standard.set(language, forKey: "selected_language")
        loadBundleForLanguage(language)
        
        // Notify UI of language change
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    private func loadBundleForLanguage(_ language: String) {
        // Load language-specific bundle
        guard let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj"),
              let languageBundle = Bundle(path: bundlePath) else {
            print("Warning: Could not load bundle for language '\(language)', falling back to main bundle")
            currentBundle = Bundle.main
            return
        }
        currentBundle = languageBundle
        print("Loaded language bundle for: \(language)")
    }
    
    func localizedString(_ key: String) -> String {
        // First try main bundle (most reliable)
        let mainBundleValue = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        if mainBundleValue != key {
            return mainBundleValue
        }
        
        // Then try current language bundle
        let localizedValue = currentBundle.localizedString(forKey: key, value: nil, table: nil)
        if localizedValue != key {
            return localizedValue
        }
        
        // If still not found, return the key itself as fallback
        print("⚠️ Missing localization for key: \(key)")
        return key
    }
    
    func localizedString(_ key: String, arguments: CVarArg...) -> String {
        let format = localizedString(key)
        return String(format: format, arguments: arguments)
    }
}

// Extension to make localization easier
extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(self)
    }
    
    func localized(_ arguments: CVarArg...) -> String {
        return LocalizationManager.shared.localizedString(self, arguments: arguments)
    }
}
