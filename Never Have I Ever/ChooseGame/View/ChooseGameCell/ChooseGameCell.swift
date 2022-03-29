//
//  ChooseGameCell.swift
//  Never Have I Ever
//
//  Created by Medef on 27.02.2021.
//  Copyright © 2021 medef00. All rights reserved.
//

import UIKit
import FSPagerView

class ChooseGameCell: FSPagerViewCell, CollectionViewCellProtocol {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static var coefficient: CGFloat = 0
    
    var viewModel: ChooseGameCellViewModelProtocol! {
        didSet {
            title.text = viewModel.gameName
            descriptionLabel.text = viewModel.gameDescription
        }
    }
    
    @IBAction func start(_ sender: UIButton) {
         viewModel.gameDidSelect?(viewModel.gameType)
    }
}
