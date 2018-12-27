//
//  IntroAnimationViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 15/11/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit

class IntroAnimationViewController: UIViewController {
    
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var introLabelYAnchor: NSLayoutConstraint!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 1, animations: {
                self.introLabelYAnchor.constant = 30
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 1, delay: 0.5, animations: {
                self.textLabel.alpha = 1
                self.continueButton.alpha = 1
            })
        }
    }
    @IBAction func closeButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "wasIntroWatched")
        userDefaults.synchronize()
        dismiss(animated: true, completion: nil)
    }
    
}
