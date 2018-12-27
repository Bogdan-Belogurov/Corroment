//
//  CoreDataStack.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var masterContext: NSManagedObjectContext {get}
    var mainContext: NSManagedObjectContext {get}
    var saveContext: NSManagedObjectContext {get}
    var persistentContainer: NSPersistentContainer {get}
    func performSave(context: NSManagedObjectContext, completionHandler: (()-> Void)?)
    func performDelete(context: NSManagedObjectContext, objectToDelete: Parameters, completionHandler: (()-> Void)?)
}

class CoreDataStack: CoreDataStackProtocol {
    
    // MARK: - NSPersistentStore
    private var storeUrl: URL {
        let documentsDirURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentsDirURL.appendingPathComponent("Store.sqlite")
        
        return url
    }
    
    // MARK: - NSManagedObjectModel
    let managedObjectModelName = "Anastasiya"
    
    lazy var managedObjectModel : NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: self.managedObjectModelName, withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
    // MARK: - Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Anastasiya")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Coordinator
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeUrl, options: nil)
        } catch {
            assert(false, "Error adding store: \(error)")
        }
        
        return coordinator
    }()
    
    // MARK: - NSManagedObjectContext
    // masterContext
    lazy var masterContext : NSManagedObjectContext = {
        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        masterContext.mergePolicy = NSOverwriteMergePolicy
        
        return masterContext
    }()
    
    // mainContext
    lazy var mainContext : NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = self.masterContext
        mainContext.mergePolicy = NSOverwriteMergePolicy
        
        return mainContext
    }()
    
    // saveContext
    lazy var saveContext : NSManagedObjectContext = {
        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.parent = self.mainContext
        saveContext.mergePolicy = NSOverwriteMergePolicy
        
        return saveContext
    }()
    
    func performSave(context: NSManagedObjectContext, completionHandler: (() -> Void)?) {
        if context.hasChanges {
            context.perform { [weak self] in
                do {
                    try context.save()
                } catch {
                    print("Context save error: \(error)")
                }
                
                if let parent = context.parent {
                    self?.performSave(context: parent, completionHandler: completionHandler)
                } else {
                    completionHandler?()
                }
            }
        } else {
            completionHandler?()
        }
    }
    
    func performDelete(context: NSManagedObjectContext, objectToDelete: Parameters, completionHandler: (() -> Void)?) {
       
        if context.hasChanges {
            context.perform { [weak self] in
               context.delete(objectToDelete)
                do {
                    try context.save()
                } catch {
                    print(print("Context save error: \(error)"))
                }
                
                if let parent = context.parent {
                    self?.performDelete(context: parent, objectToDelete: objectToDelete, completionHandler: completionHandler)
                } else {
                    completionHandler?()
                }
            }
        } else {
            completionHandler?()
        }
    }
}
