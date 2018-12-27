//
//  SaveParametersViewController.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit
import CoreData

class SaveParametersViewController: UIViewController {

    var fetchedResultsController: NSFetchedResultsController<Parameters>?
    var savedParametersDataManager: SavedParametersDataManager?
    private var parametersStorageModel = AppDelegate.rootAssembly.presentationAssembly.parametsersStorageModel
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.savedParametersDataManager = SavedParametersDataManager(tableView: self.tableView)
        self.fetchedResultsController = self.savedParametersDataManager?.fetchedResultsController
        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            print("fetching error parameters")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isEditing = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGraphs" {
            if let currentIndexPath = tableView.indexPathForSelectedRow {
                guard let dvc = segue.destination as? GraphsViewController else { return }
                let parameters = self.fetchedResultsController?.object(at: currentIndexPath)
                let parametersToGraphs = ParametersProfile(sigmaOne: (parameters?.sigmaOne)!, sigmaTwo: (parameters?.sigmaTwo)!, taoOne: (parameters?.taoOne)!, taoTwo: (parameters?.taoTwo)!)
                dvc.parameters = parametersToGraphs
                dvc.saveIsHiden = true
            }
            
            
        }
    }
    
    // MARK: - Delete Items
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if let indexPath = self.tableView?.indexPathsForVisibleRows {
            for indexPath in indexPath {
                if let cell = self.tableView.cellForRow(at: indexPath) as? ParametersTableViewCell {
                    cell.isCellEditing = editing
                }
            }
        }
    }

}

extension SaveParametersViewController: UITableViewDelegate {
    
}

extension SaveParametersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = self.fetchedResultsController?.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ParametersTableViewCell
        let parameters = self.fetchedResultsController?.object(at: indexPath)
        cell.name = parameters?.name
        cell.date = parameters?.date
        cell.sigmaOne = String(format:"%.1f", (parameters?.sigmaOne)!)
        cell.sigmaTwo = String(format:"%.1f", (parameters?.sigmaTwo)!)
        cell.taoOne = String(format:"%.1f", (parameters?.taoOne)!)
        cell.taoTwo = String(format:"%.1f", (parameters?.taoTwo)!)
        cell.delegate = self
        
        if self.isEditing {
            cell.isCellEditing = true
        } else {
            cell.isCellEditing = false
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toGraphs", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension SaveParametersViewController: ParametersCellDelegate {
    func delete(cell: ParametersTableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            guard let objectToDelete = self.fetchedResultsController?.object(at: indexPath) else {return}
            self.parametersStorageModel.deletePrarameters(objectToDelete: objectToDelete, completion: {(error) in
                if error {
                    print("Не удалось удалить")
                } else {
                    print("Удалил")
                }
            })
        }
    }
}
