//
//  ParametersStorageModelProtoc.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation
import CoreData

protocol ParametersStorageModelProtocol {
    func saveUser(parameters: ParametersProfile, completion: @escaping (_ error: Bool) -> ())
    func deletePrarameters(objectToDelete: Parameters, completion: @escaping (_ error: Bool) -> ())
}

class ParametersStorageModel: ParametersStorageModelProtocol {
    
    var parametersStorageManeger: SaveProfileProtocol
    
    init(parametersStorageManeger: SaveProfileProtocol) {
        self.parametersStorageManeger = parametersStorageManeger
    }
    
    func saveUser(parameters: ParametersProfile, completion: @escaping (Bool) -> ()) {
        self.parametersStorageManeger.saveParameters(parameters: parameters, completion: completion)
    }
    
    func deletePrarameters(objectToDelete: Parameters, completion: @escaping (Bool) -> ()) {
        self.parametersStorageManeger.deleteParameters(objectToDelete: objectToDelete, completion: completion)
    }
    
    
    
    
}
