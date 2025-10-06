import XCTest
import CoreData
@testable import ClipBear

final class AppSettingsTests: XCTestCase {
    func testKVUniqueAndReadWrite() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext

        AppSettings.setValue("pt", for: AppSettings.languageKey, in: ctx)
        AppSettings.setValue("en", for: AppSettings.languageKey, in: ctx) // overwrite
        try ctx.save()

        let lang = AppSettings.getValue(for: AppSettings.languageKey, in: ctx)
        XCTAssertEqual(lang, "en")
    }
    
    func testSettingsPersistence() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext

        AppSettings.setValue("proactive", for: AppSettings.intensityKey, in: ctx)
        AppSettings.setValue("true", for: AppSettings.diagnosticsEnabledKey, in: ctx)
        try ctx.save()

        let intensity = AppSettings.getValue(for: AppSettings.intensityKey, in: ctx)
        let diagnostics = AppSettings.getValue(for: AppSettings.diagnosticsEnabledKey, in: ctx)
        
        XCTAssertEqual(intensity, "proactive")
        XCTAssertEqual(diagnostics, "true")
    }
}

