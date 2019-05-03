//
//  SavedParametersCollectionViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SavedParametersCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var parametersStorageModel = AppDelegate.rootAssembly.presentationAssembly.parametsersStorageModel
    var parametersArray: [Parameters]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parametersArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ParametersCollectionViewCell
    
        cell.layer.cornerRadius = 16
        cell.alpha = 0.7
        cell.name = parametersArray?[indexPath.item].name
        cell.sigmaOne = String(format:"%.1f", (parametersArray?[indexPath.item].sigmaOne)!)
        cell.sigmaTwo = String(format:"%.1f", (parametersArray?[indexPath.item].sigmaTwo)!)
        cell.taoOne = String(format:"%.1f", (parametersArray?[indexPath.item].taoOne)!)
        cell.taoTwo = String(format:"%.1f", (parametersArray?[indexPath.item].taoTwo)!)
        cell.date = parametersArray?[indexPath.item].date
        cell.delegate = self
    
        return cell
    }

    func loadData() {
        self.parametersStorageModel.getParametersArray { (parameters) in
            if parameters != nil {
                self.parametersArray = parameters
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if let indexPath = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPath {
                if let cell = collectionView.cellForItem(at: indexPath) as? ParametersCollectionViewCell {
                    cell.isEditing = editing
                }
            }
        }
    }
}

extension SavedParametersCollectionViewController: ParametersCellDelegate {
    func delete(cell: ParametersCollectionViewCell) {
        if let indexPath = self.collectionView.indexPath(for: cell) {
            self.parametersArray?.remove(at: indexPath.item)
            self.collectionView.deleteItems(at: [indexPath])
        }
    }
}
