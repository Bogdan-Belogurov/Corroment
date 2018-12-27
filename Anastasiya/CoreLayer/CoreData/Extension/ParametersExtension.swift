//
//  ParametersExtension.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation
import CoreData

extension Parameters {
    
    static func insertParameters(in context: NSManagedObjectContext) -> Parameters? {
        guard let parameters = NSEntityDescription.insertNewObject(forEntityName: "Parameters", into: context) as? Parameters else {
            return nil
        }
        return parameters
    }
    
    static func findParameters( in context: NSManagedObjectContext) -> [Parameters]? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print ("Model is not available in context")
            assert(false)
            return nil
        }
        var parametersArray : [Parameters]?
        guard let fetchRequest = Parameters.fetchRequestParameters(model: model) else {
            return nil
        }
        do {
            let results = try context.fetch(fetchRequest)
            parametersArray = results
        } catch {
            print ("Failed to fetch appUser: \(error)")
        }
        
        return parametersArray
        
    }
    
    static func fetchRequestParameters(model: NSManagedObjectModel) -> NSFetchRequest<Parameters>? {
        let templateName = "Parameters"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<Parameters> else {
            assert(false,"No template with name \(templateName)")
            return nil
        }
        return fetchRequest
    }
}
