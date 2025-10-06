import CoreData
import XCTest
@testable import ClipBear

final class TestingCoreData {
    static func inMemoryContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "ClipBearDataModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }
}

