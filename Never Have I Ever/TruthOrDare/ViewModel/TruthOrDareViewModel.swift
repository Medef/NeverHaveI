//
//  TruthOrDareViewModel.swift
//  Never Have I Ever
//
//  Created by Medef on 29.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import Foundation

protocol TruthOrDareViewModelProtocol: AnyObject { 
    init(players: [String])
    var currentPlayer: String { get }
    func nextPlayer()
    func getQuestion(for state: TruthOrDareState) -> String
    func updateQuestions(_ questionType: TruthOrDareState)
    func selectButton(_ completion: (() -> Void)?) -> TruthOrDareState
}

class TruthOrDareViewModel: TruthOrDareViewModelProtocol {
    
    private var players: [String]
    
    private var shuffledPlayers: [String]
    
    private var shuffledDare = Questions.dareList.shuffled()
    private var shuffledTruth = Questions.truthList.shuffled()
    
    private var playerIndex = 0
    private var dareIndex = 0
    private var truthIndex = 0
    
    var currentPlayer: String {
        return shuffledPlayers[playerIndex]
    }
    
    required init(players: [String]) {
        self.players = players
        shuffledPlayers = players.shuffled()
    }
    
    private func insertPlayer(to question: String) -> String {
        let player = players[Int.random(in: 0...players.count - 1)]
        if player == currentPlayer {
            return insertPlayer(to: question)
        } else {
            return question.replacingOccurrences(of: "*", with: player)
        }
    }
    
    func nextPlayer() {
        let isLastPlayer = playerIndex == players.count - 1
        playerIndex = isLastPlayer ? 0 : playerIndex + 1
        if isLastPlayer { shuffledPlayers = players.shuffled() }
    }
    
    func getQuestion(for state: TruthOrDareState) -> String {
        switch state {
        case .initial:
            return ""
        case .truth:
            return insertPlayer(to: shuffledTruth[truthIndex])
        case .dare:
            return insertPlayer(to: shuffledDare[dareIndex])
        case .random:
            return ""
        }
    }
    
    func updateQuestions(_ questionType: TruthOrDareState) {
        switch questionType {
        case .truth:
            let isLastTruthQuestion = truthIndex == Questions.truthList.count - 1
            truthIndex = isLastTruthQuestion ? 0 : truthIndex + 1
            if isLastTruthQuestion { shuffledTruth = Questions.truthList.shuffled() }
        case .dare:
            let isLastDareQuestion = dareIndex == Questions.dareList.count - 1
            dareIndex = isLastDareQuestion ? 0 : dareIndex + 1
            if isLastDareQuestion { shuffledDare = Questions.dareList.shuffled() }
        default:
            break
        }
    }
    
    func selectButton(_ completion: (() -> Void)?) -> TruthOrDareState {
        let questionTypes: [TruthOrDareState] = [.truth, .dare]
        let randomQuestionType = questionTypes.randomElement()!
        completion?()
        return randomQuestionType
    }
    
}
