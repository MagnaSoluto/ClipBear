import Foundation
import UserNotifications
import CoreData

class NotificationService: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationService()
    
    private override init() {
        super.init()
    }
    
    func requestPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge, .provisional]
            )
            return granted
        } catch {
            print("Error requesting notification permission: \(error)")
            return false
        }
    }
    
    func scheduleSuggestionNotification(
        message: String,
        explanation: String,
        ruleId: String,
        language: String
    ) {
        let content = UNMutableNotificationContent()
        content.title = "Tinker"
        content.body = message
        content.sound = .default
        content.categoryIdentifier = "SUGGESTION_CATEGORY"
        
        // Add explanation as user info
        content.userInfo = [
            "explanation": explanation,
            "ruleId": ruleId,
            "language": language
        ]
        
        // Schedule for immediate delivery
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(
            identifier: "suggestion_\(ruleId)_\(Date().timeIntervalSince1970)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func setupNotificationCategories() {
        let acceptAction = UNNotificationAction(
            identifier: "ACCEPT_ACTION",
            title: "notification.accept".localized,
            options: []
        )
        
        let rejectAction = UNNotificationAction(
            identifier: "REJECT_ACTION",
            title: "notification.reject".localized,
            options: []
        )
        
        let category = UNNotificationCategory(
            identifier: "SUGGESTION_CATEGORY",
            actions: [acceptAction, rejectAction],
            intentIdentifiers: [],
            options: []
        )
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().delegate = self
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        handleNotificationResponse(response)
        completionHandler()
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show notification even when app is in foreground
        completionHandler([.banner, .sound, .badge])
    }
    
    func handleNotificationResponse(_ response: UNNotificationResponse) {
        guard let userInfo = response.notification.request.content.userInfo as? [String: Any],
              let ruleId = userInfo["ruleId"] as? String else {
            return
        }
        
        _ = response.actionIdentifier == "ACCEPT_ACTION"
        let context = PersistenceController.shared.container.viewContext
        
        handleAction(identifier: response.actionIdentifier, ruleId: ruleId, context: context)
    }
    
    // Testable handler for unit tests
    func handleAction(identifier: String, ruleId: String?, context: NSManagedObjectContext) {
        guard let rule = ruleId else { return }
        let accepted = identifier == "ACCEPT_ACTION"
        
        _ = SuggestionFeedback.create(
            ruleId: rule,
            accepted: accepted,
            sessionId: "notification_\(Date().timeIntervalSince1970)",
            in: context
        )
        
        do {
            try context.save()
        } catch {
            print("Error saving feedback: \(error)")
        }
    }
}
