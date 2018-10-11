//
//  ViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 11/10/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 20
        calculateButton.layer.borderWidth = 1.0
        calculateButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        calculateButton.clipsToBounds = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

