//
//  DesignableButton.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 15/11/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignableButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
