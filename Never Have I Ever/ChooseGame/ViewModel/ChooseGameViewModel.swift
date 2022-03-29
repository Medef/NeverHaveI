//
//  ChooseGameViewModel.swift
//  Never Have I Ever
//
//  Created by Medef on 27.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import Foundation

protocol ChooseGameViewModelProtocol: AnyObject {
    var numberOfRows: Int { get }
    func cellViewModel(at index: Int) -> ChooseGameCellViewModelProtocol
}

class ChooseGameViewModel: ChooseGameViewModelProtocol {
    
    var numberOfRows: Int {
        GameType.allCases.count
    }
    
    func cellViewModel(at index: Int) -> ChooseGameCellViewModelProtocol {
        let gameType = GameType.allCases[index]
        return ChooseGameCellViewModel(game: gameType)
    }
    
    deinit {
        print("deinit ChooseGameViewModel")
    }
}
