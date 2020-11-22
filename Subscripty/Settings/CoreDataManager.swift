//
//  CoreDataManager.swift
//  Subscripty
//
//  Created by Михаил Борисов on 14.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataManager {

    static var shared = CoreDataStack()

    private init() {}
}

final class CoreDataStack {

    internal enum Contexts {
        case main, `private`
    }

    internal func context(on context: Contexts) -> NSManagedObjectContext {
        switch context {
        case .main:
            return mainContext
        case .private:
            return backgroundContext
        }
    }

    private lazy var backgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()

    private lazy var mainContext: NSManagedObjectContext = persistentContainer.viewContext

    private lazy var persistentContainer = NSPersistentContainer(name: "Subscripty").with { container in
        container.loadPersistentStores { (_, err) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }

    internal func saveContext(backgroundContext: NSManagedObjectContext? = nil) {

        let context = backgroundContext ?? persistentContainer.viewContext

        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch(let err) {
            print(err.localizedDescription)
        }
    }

}
