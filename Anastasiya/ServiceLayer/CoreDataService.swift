//
//  CoreDataService.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    var mainContext: NSManagedObjectContext {get}
    var saveContext: NSManagedObjectContext {get}
    func performSave(context: NSManagedObjectContext, completionHandler: (()-> Void)?)
}

class CoreDataService: CoreDataServiceProtocol {
    
    private var coreDataStackService: CoreDataStackProtocol
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStackService = coreDataStack
    }
    
    var mainContext: NSManagedObjectContext {
        get { return self.coreDataStackService.mainContext }
    }
    
    var saveContext: NSManagedObjectContext {
        get { return self.coreDataStackService.saveContext }
    }
    
    func performSave(context: NSManagedObjectContext, completionHandler: (()-> Void)?) {
        self.coreDataStackService.performSave(context: context, completionHandler: completionHandler)
    }
    
}
