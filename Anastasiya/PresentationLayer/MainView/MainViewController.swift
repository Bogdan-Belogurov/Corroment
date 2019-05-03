//
//  MainViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 03/05/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    lazy var parametersManager: ParametersManager = AppDelegate.rootAssembly.presentationAssembly.parametersManager
    
    @IBOutlet weak var introLabel: UILabel!
    var patemeters: [ParameterProfile] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ParameterTableViewCell", bundle: nil), forCellReuseIdentifier: "parameter")
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
    }
    override func viewWillAppear(_ animated: Bool) {
        self.patemeters = parametersManager.getParrameters()
        self.tableView.reloadData()
        if patemeters.isEmpty {
            introLabel.alpha = 1
            tableView.alpha = 0
        } else {
            introLabel.alpha = 0
            tableView.alpha = 1
        }
        
        super.viewWillAppear(animated)
        let userDefaults = UserDefaults.standard
        let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
        guard !wasIntroWatched else {return}
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "introAnimationViewController") as? IntroAnimationViewController {
            present(pageViewController, animated: true, completion: nil)
        }
    }
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patemeters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let parameter = self.patemeters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "parameter", for: indexPath) as? ParameterTableViewCell
        cell?.time = parameter.time
        cell?.sigma = parameter.sigma
        cell?.selectionStyle = .none
        return cell!
    }
    
    
}
extension MainViewController: UITableViewDelegate {
    
}
