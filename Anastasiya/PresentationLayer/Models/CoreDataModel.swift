//
//  CoreDataModel.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataModelProtocol {
    var mainContext: NSManagedObjectContext { get }
}
class CoreDataModel: CoreDataModelProtocol {
    
    private var coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }
    
    var mainContext: NSManagedObjectContext {
        get {return self.coreDataService.mainContext}
    }
    
}
