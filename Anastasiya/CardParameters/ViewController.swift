//
//  ViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 11/10/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIViewX!
    @IBOutlet weak var sigmaOneTextField: UITextField!
    @IBOutlet weak var sigmaTwoTextField: UITextField!
    @IBOutlet weak var taoOneTextField: UITextField!
    @IBOutlet weak var taoTwoTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButtonX!
    @IBOutlet weak var heightViewConstraint: NSLayoutConstraint!
    var formatter: NumberFormatter?
    
    @IBAction func textFieldAction(_ sender: Any) {
        checkCardInput()
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        print("push")
        performSegue(withIdentifier: "toGraphs", sender: nil)
    }
    
    var cardToCalculate: ParametersProfile? {
        
        guard let sigmaOne = sigmaOneTextField.text else {return nil}
        guard let sigmaTwo = sigmaTwoTextField.text else {return nil}
        guard let taoOne = taoOneTextField.text else {return nil}
        guard let taoTwo = taoTwoTextField.text else {return nil}

        
        if sigmaOne.isEmpty || sigmaTwo.isEmpty || taoOne.isEmpty || taoTwo.isEmpty {
            return nil
        }
        
        guard let so = self.formatter?.number(from: sigmaOne)?.doubleValue else { return nil }
        guard let st = self.formatter?.number(from: sigmaTwo)?.doubleValue else { return nil }
        guard let to = self.formatter?.number(from: taoOne)?.doubleValue else { return nil }
        guard let tt = self.formatter?.number(from: taoTwo)?.doubleValue else { return nil }
        
        return ParametersProfile(sigmaOne: so, sigmaTwo: st, taoOne: to, taoTwo: tt)
    }
    
    func checkCardInput() {
        if cardToCalculate != nil {
            if self.heightViewConstraint.constant != 336 {
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.heightViewConstraint.constant = 336
                    self.view.layoutIfNeeded()
                }) { (success) in
                    if success {
                        if self.heightViewConstraint.constant == 336 {
                        UIView.animate(withDuration: 0.2) {
                            self.calculateButton.alpha = 1
                        }
                        }
                    }
                }
            }
        } else {
            if self.heightViewConstraint.constant != 260 {
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.calculateButton.alpha = 0
                }) { (success) in
                    if success {
                        UIView.animate(withDuration: 0.2) {
                            self.heightViewConstraint.constant = 260
                            self.view.layoutIfNeeded()
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightViewConstraint.constant = 260
        self.calculateButton.alpha = 0
        formatter = NumberFormatter()
        formatter?.locale = Locale.current
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        sigmaOneTextField.text = nil
//        sigmaTwoTextField.text = nil
//        taoOneTextField.text = nil
//        taoTwoTextField.text = nil
        self.checkCardInput()
        let userDefaults = UserDefaults.standard
        let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
        guard !wasIntroWatched else {return}
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "introAnimationViewController") as? IntroAnimationViewController {
            present(pageViewController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGraphs" {
            guard let dvc = segue.destination as? GraphsViewController else { return }
            guard let parametersToGraphs = cardToCalculate else {return}
            dvc.parameters = parametersToGraphs
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
