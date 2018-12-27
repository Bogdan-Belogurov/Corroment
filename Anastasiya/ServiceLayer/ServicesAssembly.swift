//
//  ServiceAssembly.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation

protocol ServicesAssemblyProtocol {
    var parametersStorageManager: SaveProfileProtocol { get }
    var coreDataService: CoreDataServiceProtocol { get }
}

class ServicesAssembly: ServicesAssemblyProtocol {
    
    public let coreAssembly: CoreAssemblyProtocol
    
    init(coreAssembly: CoreAssemblyProtocol) {
        self.coreAssembly = coreAssembly
    }
    lazy var parametersStorageManager: SaveProfileProtocol = ParametersStorageManager(coreDataStack: self.coreAssembly.coreDataStack)
    lazy var coreDataService: CoreDataServiceProtocol = CoreDataService(coreDataStack: self.coreAssembly.coreDataStack)
}
