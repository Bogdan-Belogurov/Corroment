//
//  ParameterTableViewCell.swift
//  Anastasiya
//
//  Created by Bogdan Belogurov on 03/05/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit

class ParameterTableViewCell: UITableViewCell {

    @IBOutlet weak var sigmaLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var time: Double? {
        didSet {
            guard let time = self.time else {
                return
            }
            self.timeLabel.text = String(time)
        }
    }
    var sigma: Double? {
        didSet {
            guard let sigma = self.sigma else {
                return
            }
            self.sigmaLabel.text = String(sigma)
        }
    }
    
}
