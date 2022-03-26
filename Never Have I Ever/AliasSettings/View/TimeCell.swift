//
//  TimeCell.swift
//  Never Have I Ever
//
//  Created by Medef on 08.08.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBAction func changeTime(_ sender: UISlider) {
        secondsLabel.text = "\(Int(slider.value))"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
