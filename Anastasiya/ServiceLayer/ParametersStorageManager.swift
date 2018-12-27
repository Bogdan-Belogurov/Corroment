//
//  ParametersStorageManager.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation
import CoreData

protocol SaveProfileProtocol {
    func saveParameters(parameters: ParametersProfile, completion: @escaping (_ success: Bool) -> ())
    func deleteParameters(objectToDelete: Parameters, completion: @escaping (_ success: Bool) -> ())
    
}

class ParametersStorageManager: SaveProfileProtocol {

    private var coreDataStack: CoreDataStackProtocol
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }
    
    func saveParameters(parameters: ParametersProfile, completion: @escaping (Bool) -> Void) {
         let context = self.coreDataStack.saveContext
        context.perform {
            let parametersEntity = Parameters.insertParameters(in: context).self
            parametersEntity?.name = parameters.name
            parametersEntity?.date = parameters.date
            parametersEntity?.sigmaOne = parameters.sigmaOne
            parametersEntity?.sigmaTwo = parameters.sigmaTwo
            parametersEntity?.taoOne = parameters.taoOne
            parametersEntity?.taoTwo = parameters.taoTwo
            self.coreDataStack.performSave(context: context) {
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }
    }
    
    func deleteParameters(objectToDelete: Parameters, completion: @escaping (Bool) -> Void) {
        let context = self.coreDataStack.mainContext
        context.delete(objectToDelete)
        self.coreDataStack.performDelete(context: context, objectToDelete: objectToDelete) {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}

