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
        self.setCalculateButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showIntroContoller()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setCalculateButton() {
        calculateButton.layer.cornerRadius = 20
        calculateButton.layer.borderWidth = 1.0
        calculateButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        calculateButton.clipsToBounds = true
    }
    
    func showIntroContoller()  {
        let userDefaults = UserDefaults.standard
        let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
        guard !wasIntroWatched else {return}
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "introAnimationViewController") as? IntroAnimationViewController {
            present(pageViewController, animated: true, completion: nil)
        }
    }


}



