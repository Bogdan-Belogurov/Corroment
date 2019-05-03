//
//  ParameterManager.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 03/05/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import Foundation

protocol ParametersManagerProtocol {
    func appendParameter(with value: ParameterProfile)
    func getParrameters() -> [ParameterProfile]
    func getTime() -> [Double]
    func getSigma() -> [Double] 
}

class ParametersManager: ParametersManagerProtocol {
    private var parametersStack: [ParameterProfile] = []
    init() {
    }
    
    func appendParameter(with value: ParameterProfile) {
        parametersStack.append(value)
    }
    
    func getParrameters() -> [ParameterProfile] {
        return self.parametersStack
    }
    
    func getTime() -> [Double] {
        var time: [Double] = []
        for item in self.parametersStack {
            time.append(item.time)
        }
        return time
    }
    func getSigma() -> [Double] {
        var sigma: [Double] = []
        for item in self.parametersStack {
            sigma.append(item.sigma)
        }
        return sigma
    }
}
