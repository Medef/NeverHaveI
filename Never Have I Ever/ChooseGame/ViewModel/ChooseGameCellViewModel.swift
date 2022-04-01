//
//  ChooseGameCellViewModel.swift
//  Never Have I Ever
//
//  Created by Medef on 27.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import Foundation

protocol ChooseGameCellViewModelProtocol: AnyObject {
    var gameName: String { get }
    var gameDescription: String { get }
    var gameType: GameType { get }
    var gameDidSelect: ((_ gameType: GameType) -> Void)? { get set }
    init(game: GameType)
}

class ChooseGameCellViewModel: ChooseGameCellViewModelProtocol {
    private let game: GameType
    
    var gameName: String {
        game.rawValue
    }
    
    var gameDescription: String {
        game.getDescription()
    }
    
    var gameType: GameType {
        game
    }
    
    var gameDidSelect: ((_ gameType: GameType) -> Void)?
    
    required init(game: GameType) {
        self.game = game
    }
}
