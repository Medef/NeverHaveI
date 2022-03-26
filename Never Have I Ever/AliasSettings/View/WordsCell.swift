//
//  WordsCell.swift
//  Never Have I Ever
//
//  Created by Medef on 08.08.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class WordsCell: UITableViewCell {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var wordsAmount: UILabel!
    
    @IBAction func changeAmount(_ sender: UISlider) {
        wordsAmount.text = "\(Int(slider.value))"
    }
    
}
