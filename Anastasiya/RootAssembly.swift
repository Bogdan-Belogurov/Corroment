//
//  RootAssembly.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation

class RootAssembly {
    //lazy var presentationAssembly: PresentationAssemblyProtocol = PresentationAssembly(serviceAssembly: self.serviceAssembly)
    //private lazy var serviceAssembly: ServicesAssemblyProtocol = ServicesAssembly(coreAssembly: self.coreAssembly)
    lazy var presentationAssembly: PresentationAssemblyProtocol = PresentationAssembly(serviceAssembly: self.servicesAssembly)
    private lazy var servicesAssembly: ServicesAssemblyProtocol = ServicesAssembly(coreAssembly: self.coreAssembly)
    private lazy var coreAssembly: CoreAssemblyProtocol = CoreAssembly()
    
}
