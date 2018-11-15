//
//  ViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 11/10/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.row == 0 {
            print(indexPath)
            cell = tableView.dequeueReusableCell(withIdentifier: "1")
        }
        if indexPath.row == 1 {
            print(indexPath)
            cell = tableView.dequeueReusableCell(withIdentifier: "2")
        }
        
        if indexPath.row == 2 {
            print(indexPath)
            cell = tableView.dequeueReusableCell(withIdentifier: "3")
        }
        
        if indexPath.row == 3 {
            print(indexPath)
            cell = tableView.dequeueReusableCell(withIdentifier: "4")
        }
        
        return cell!
        
    }
    
    
}


