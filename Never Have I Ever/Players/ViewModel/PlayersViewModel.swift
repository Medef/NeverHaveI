//
//  PlayersViewModel.swift
//  Never Have I Ever
//
//  Created by Medef on 28.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import Foundation

protocol PlayersViewModelProtocol: AnyObject {
    var players: [String] { get }
    var gameType: GameType { get }
    var numberOfRows: Int { get }
    func addPlayer(_ name: String)
    func prepareGameToStart(completion: ((_ success: Bool) -> ())?)
    func cellViewModel(at indexPath: IndexPath) -> PlayerCellViewModelProtocol
    func removePlayer(at indexPath: IndexPath)
    init(_ gameType: GameType)
}

class PlayersViewModel: PlayersViewModelProtocol {
    
    var players: [String] = []
    
    var gameType: GameType
    
    var numberOfRows: Int {
        players.count
    }
    
    required init(_ gameType: GameType) {
        self.gameType = gameType
    }
    
    func cellViewModel(at indexPath: IndexPath) -> PlayerCellViewModelProtocol {
        let player = players[indexPath.row]
        return PlayerCellViewModel(player: player, at: indexPath)
    }
    
    func removePlayer(at indexPath: IndexPath) {
        players.remove(at: indexPath.row)
    }
    
    func addPlayer(_ name: String) {
        players.append(name)
    }
    
    func prepareGameToStart(completion: ((_ success: Bool) -> ())?) {
        if players.count > 1 {
            completion?(true)
        } else {
            completion?(false)
        }
    }
    
    deinit {
        print("deinit PlayersViewModel")
    }
}
