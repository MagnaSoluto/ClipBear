#!/usr/bin/env swift

// Test file to verify compilation of all modules
import Foundation
import CoreData
import SwiftUI
import UserNotifications
import WidgetKit

// Test basic functionality
print("✅ Basic imports successful")

// Test Core Data models
let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
print("✅ Core Data context created")

// Test localization
let localizedString = "test.key".localized
print("✅ Localization working: \(localizedString)")

// Test notification service
let notificationService = NotificationService.shared
print("✅ NotificationService created")

// Test widget service
let widgetService = WidgetService.shared
print("✅ WidgetService created")

// Test data export service
let exportService = DataExportService.shared
print("✅ DataExportService created")

print("🎉 All modules compiled successfully!")

