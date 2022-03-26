//
//  PlayerViewCell.swift
//  Never Have I Ever
//
//  Created by Medef on 03.05.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    static let id = "PlayerCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }

}
