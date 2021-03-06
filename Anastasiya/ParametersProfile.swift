//
//  ParametersProfile.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 19/11/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation

class ParametersProfile {
    var name: String?
    var date: Date?
    
    var sigmaOne: Double
    var sigmaTwo: Double
    var taoOne: Double
    var taoTwo: Double    
    
    
    init(sigmaOne: Double, sigmaTwo: Double, taoOne: Double, taoTwo: Double) {
        self.sigmaOne = sigmaOne
        self.sigmaTwo = sigmaTwo
        self.taoOne = taoOne
        self.taoTwo = taoTwo
    }
}

class ParameterProfile {
    
    var sigma: Double
    var time: Double
    
    
    init(time: Double, sigma: Double) {
        self.time = time
        self.sigma = sigma
    }
}
