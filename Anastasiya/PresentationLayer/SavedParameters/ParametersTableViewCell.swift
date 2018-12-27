//
//  ParametersTableViewCell.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 26/12/2018.
//  Copyright © 2018 Bogdan Belogurov. All rights reserved.
//

import UIKit

protocol ParametersCellDelegate: class {
    func delete(cell: ParametersTableViewCell)
    
}

class ParametersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sigmaOneLabel: UILabel!
    @IBOutlet weak var sigmaTwoLabel: UILabel!
    @IBOutlet weak var taoOneLabel: UILabel!
    @IBOutlet weak var taoTwoLabel: UILabel!
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    weak var delegate: ParametersCellDelegate?

    private let dateFormatter = DateFormatter()
    var isCellEditing: Bool = false {
        didSet {
            
            if isCellEditing {
                UIView.animate(withDuration: 0.3) {
                    self.deleteButtonBackgroundView.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.deleteButtonBackgroundView.alpha = 0
                }
            }
            deleteButtonBackgroundView.isHidden = !isCellEditing
            self.deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width / 2.0
            self.deleteButtonBackgroundView.layer.masksToBounds = true
        }
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
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
