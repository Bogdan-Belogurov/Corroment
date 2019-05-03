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
    @IBOutlet weak var taoOneTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButtonX!
    @IBOutlet weak var heightViewConstraint: NSLayoutConstraint!
    var pointParameter: ParameterProfile?
    var formatter: NumberFormatter?
    lazy var parametersManager: ParametersManager = AppDelegate.rootAssembly.presentationAssembly.parametersManager
    @IBAction func textFieldAction(_ sender: Any) {
        checkCardInput()
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        guard let point = self.pointParameter else {
            return
        }
        parametersManager.appendParameter(with: point)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var cardToCalculate: ParameterProfile? {
        
        guard let sigmaOne = sigmaOneTextField.text else {return nil}
        guard let taoOne = taoOneTextField.text else {return nil}

        
        if sigmaOne.isEmpty || taoOne.isEmpty {
            return nil
        }
        
        guard let so = self.formatter?.number(from: sigmaOne)?.doubleValue else { return nil }
        guard let to = self.formatter?.number(from: taoOne)?.doubleValue else { return nil }
        
        return ParameterProfile(time: to, sigma: so)
    }
    
    func checkCardInput() {
        self.pointParameter = cardToCalculate
        if pointParameter != nil {
            if self.heightViewConstraint.constant != 236 {
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.heightViewConstraint.constant = 236
                    self.view.layoutIfNeeded()
                }) { (success) in
                    if success {
                        if self.heightViewConstraint.constant == 236 {
                        UIView.animate(withDuration: 0.2) {
                            self.calculateButton.alpha = 1
                        }
                        }
                    }
                }
            }
        } else {
            if self.heightViewConstraint.constant != 140 {
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.calculateButton.alpha = 0
                }) { (success) in
                    if success {
                        UIView.animate(withDuration: 0.2) {
                            self.heightViewConstraint.constant = 140
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

        self.checkCardInput()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGraphs" {
            guard let dvc = segue.destination as? GraphsViewController else { return }
            guard let parametersToGraphs = cardToCalculate else {return}
            dvc.saveIsHiden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
