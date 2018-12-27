//
//  SavedParametersDataManager.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class SavedParametersDataManager: NSObject {
    
    let fetchedResultsController: NSFetchedResultsController<Parameters>
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        let fetchRequest = NSFetchRequest<Parameters>(entityName: "Parameters")
        let sortByTimestamp = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortByTimestamp]
        self.fetchedResultsController = NSFetchedResultsController<Parameters>(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.rootAssembly.presentationAssembly.coreDataModel.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        self.fetchedResultsController.delegate = self
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension SavedParametersDataManager: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange  anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .right)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .right)
            }
        case .move:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .right)
            }
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .right)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .right)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}
