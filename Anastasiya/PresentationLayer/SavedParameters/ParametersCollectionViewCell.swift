//
//  ParametersCollectionViewCell.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit

protocol ParametersCellDelegate: class {
    func delete(cell: ParametersCollectionViewCell)
}

class ParametersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sigmaOneLabel: UILabel!
    @IBOutlet weak var sigmaTwoLabel: UILabel!
    @IBOutlet weak var taoOneLabel: UILabel!
    @IBOutlet weak var taoTwoLabel: UILabel!
    
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    weak var delegate: ParametersCellDelegate?
    
    private let dateFormatter = DateFormatter()
    var isEditing: Bool = false {
        didSet {
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
            self.deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width / 2.0
            self.deleteButtonBackgroundView.layer.masksToBounds = true
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    var date: Date? {
        didSet {
            guard let date = self.date else {
                dateLabel.text = ""
                return
            }
            
            let checkFormat = Calendar.current.compare(Date(), to: date, toGranularity: .day)
            switch checkFormat {
            case .orderedSame:
                dateFormatter.dateFormat = "HH:mm"
                dateLabel.text = dateFormatter.string(from: date)
                break
            default:
                dateFormatter.dateFormat = "dd MMM"
                dateLabel.text = dateFormatter.string(from: date)
                break
            }
        }
    }
    
    var sigmaOne: String? {
        didSet {
            sigmaOneLabel.text = sigmaOne
        }
    }
    
    var sigmaTwo: String? {
        didSet {
            sigmaTwoLabel.text = sigmaTwo
        }
    }
    
    var taoOne: String? {
        didSet {
            taoOneLabel.text = taoOne
        }
    }
    
    var taoTwo: String? {
        didSet {
            taoTwoLabel.text = taoTwo
        }
    }

    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
        
    }
    
    
    
}
