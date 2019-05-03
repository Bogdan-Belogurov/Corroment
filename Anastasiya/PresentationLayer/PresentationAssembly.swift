//
//  PresentationAssembly.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation

protocol PresentationAssemblyProtocol {
    var parametsersStorageModel: ParametersStorageModelProtocol { get }
    var coreDataModel: CoreDataModelProtocol { get }
    var parametersManager: ParametersManager { get }
}

class PresentationAssembly: PresentationAssemblyProtocol {
    
    private let serviceAssembly: ServicesAssemblyProtocol
    
    init(serviceAssembly: ServicesAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
    }
     lazy var parametsersStorageModel: ParametersStorageModelProtocol = ParametersStorageModel(parametersStorageManeger: self.serviceAssembly.parametersStorageManager)
    
    lazy var coreDataModel: CoreDataModelProtocol = CoreDataModel(coreDataService: self.serviceAssembly.coreDataService)
    
    lazy var parametersManager: ParametersManager = ParametersManager()
}
