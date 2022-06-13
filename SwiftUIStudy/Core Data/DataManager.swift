//
//  DataManager.swift
//  SwiftUIStudy
//
//  Created by dexiong on 2022/6/8.
//

import Foundation
import CoreData


struct DataManager {
    
    //MARK: - public
    
    internal static let shared: DataManager = .init()
    internal let container: NSPersistentContainer
    
    init() {
        guard let modelUrl = Bundle.main.url(forResource: "ToDo", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelUrl),
              let storeUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDo.sqlite") else {
            fatalError("core data init error")
        }
        container = .init(name: "ToDo", managedObjectModel: model)
        let storeDescription = NSPersistentStoreDescription(url: storeUrl)
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.shouldInferMappingModelAutomatically = true
        storeDescription.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            } else {
                print(description)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    /// 保存
    internal func saveContext() {
        if container.viewContext.hasChanges {
           try? container.viewContext.save()
        }
    }
    
    /// 删除
    internal func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
        saveContext()
    }
    
}
