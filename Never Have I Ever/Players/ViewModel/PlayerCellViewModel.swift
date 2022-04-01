//
//  PlayerCellViewModel.swift
//  Never Have I Ever
//
//  Created by Medef on 28.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import Foundation

protocol PlayerCellViewModelProtocol: AnyObject {
    var deleteDidSelect: ((_ indexPath: IndexPath) -> Void)? { get set }
    var player: String { get }
    var indexPath: IndexPath { get }
    init(player: String, at indexPath: IndexPath)
}

class PlayerCellViewModel: PlayerCellViewModelProtocol {
    
    var indexPath: IndexPath
    
    var player: String
    
    var deleteDidSelect: ((_ indexPath: IndexPath) -> Void)?
    
    required init(player: String, at indexPath: IndexPath) {
        self.player = player
        self.indexPath = indexPath
    }
}
