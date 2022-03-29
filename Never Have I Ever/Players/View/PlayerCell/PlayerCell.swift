//
//  PlayerViewCell.swift
//  Never Have I Ever
//
//  Created by Medef on 03.05.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class PlayerCell: UICollectionViewCell, CollectionViewCellProtocol {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    static var coefficient: CGFloat = 0
    
    var viewModel: PlayerCellViewModelProtocol! {
        didSet {
            nameLabel.text = viewModel.player
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
    
    @IBAction func deletePlayer(_ sender: UIButton) {
        viewModel.deleteDidSelect?(viewModel.indexPath)
    }
}
