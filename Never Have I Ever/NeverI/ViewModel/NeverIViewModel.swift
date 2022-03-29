//
//  NeverIViewModel.swift
//  Never Have I Ever
//
//  Created by Medef on 28.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import Foundation

protocol NeverIViewModelProtocol {
    var questionIndex: Int { get }
    var questions: [String] { get }
    var currentQuestion: String { get }
    var titleForQuestion: String { get }
    func prepareNextQuestion(_ completion: ((_ questionsOver: Bool) -> ())?)
    func preparePreviousQuestion(_ completion: ((_ success: Bool) -> ())?)
}

class NeverIViewModel: NeverIViewModelProtocol {
    var questionIndex: Int = 0
    
    var questions: [String] = Questions.neverIHave.shuffled()
    
    var currentQuestion: String {
        return questions[questionIndex]
    }
    
    var titleForQuestion: String {
        return questions[questionIndex][0...3] == "было" ? "У меня никогда не..." : "Я никогда не..."
    }
    
    func prepareNextQuestion(_ completion: ((Bool) -> ())?) {
        if questionIndex != questions.count - 1 {
            questionIndex += 1
        } else {
            questions = Questions.neverIHave.shuffled()
            questionIndex = 0
        }
        completion?(questionIndex == questions.count - 1)
    }
    
    func preparePreviousQuestion(_ completion: ((Bool) -> ())?) {
        if questionIndex != 0 {
            questionIndex -= 1
            completion?(true)
        } else {
            completion?(false)
        }
    }
    
    deinit {
        print("deinit NeverIViewModel")
    }
}
