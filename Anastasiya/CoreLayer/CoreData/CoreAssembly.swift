//
//  CoreAssembly.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation

protocol CoreAssemblyProtocol {
    var coreDataStack: CoreDataStackProtocol { get }
    
}

class CoreAssembly: CoreAssemblyProtocol {
    lazy var coreDataStack: CoreDataStackProtocol = CoreDataStack()
}
