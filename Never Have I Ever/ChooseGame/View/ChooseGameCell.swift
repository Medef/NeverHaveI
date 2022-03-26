//
//  ChooseGameCell.swift
//  Never Have I Ever
//
//  Created by Medef on 27.02.2021.
//  Copyright © 2021 medef00. All rights reserved.
//

import UIKit
import FSPagerView

class ChooseGameCell: FSPagerViewCell {
    
    static let id = "ChooseGameCell"
    
    var delegate: ChooseGameCellDelegate?
    
    var index: Int?

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func start(_ sender: UIButton) {
        guard let index = self.index else {
            return
        }
        delegate?.chooseGame(index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
