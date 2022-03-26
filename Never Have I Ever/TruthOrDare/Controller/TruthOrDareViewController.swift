//
//  TruthOrDareViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 03.05.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class TruthOrDareViewController: UIViewController {
    
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var truthDareStack: UIStackView!
    @IBOutlet weak var truthButton: UIButton!
    @IBOutlet weak var dareButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    
    var players: [String] = []
    
    var randomPlayers: [String] = []
    var randomTruth: [String] = []
    var randomDare: [String] = []
    
    var playerIndex = 0
    var truthIndex = 0
    var dareIndex = 0
    
    let delayState = Throttler(minimumDelay: 3)
    
    @IBAction func truth(_ sender: UIButton) {
        setState(1)
    }
    
    @IBAction func dare(_ sender: UIButton) {
        setState(2)
    }
    
    @IBAction func chooseRandom(_ sender: UIButton) {
        setState(3)
    }
    
    @IBAction func ready(_ sender: UIButton) {
        setState(0)
    }
    
    // MARK: - изменение состояния
    
    func setState(_ index: Int) {
        switch index {
        // Обнулить все (кнопка готово)
        case 0:
            player.text = randomPlayers[self.playerIndex]
            if playerIndex != players.count - 1 {
                playerIndex += 1
            } else {
                randomPlayers = players.shuffled()
                playerIndex = 0
            }
            readyButton.isHidden = true
            question.text = ""
            truthDareStack.isHidden = false
            randomButton.isHidden = false
            titleLabel.text = "Правда или действие?"
            dareButton.backgroundColor = UIColor(named: "orangeYellow")
            truthButton.backgroundColor = UIColor(named: "orangeYellow")
        // Правда
        case 1:
            readyButton.isHidden = false
            question.text = setPlayer(to: randomTruth[truthIndex])
            if truthIndex != Questions.truthList.count - 1 {
                truthIndex += 1
            } else {
                randomTruth = Questions.truthList.shuffled()
                truthIndex = 0
            }
            truthDareStack.isHidden = true
            randomButton.isHidden = true
            titleLabel.text = "Правда"
        // Действие
        case 2:
            readyButton.isHidden = false
            question.text = setPlayer(to: randomDare[dareIndex])
            if dareIndex != Questions.dareList.count - 1 {
                dareIndex += 1
            } else {
                randomDare = Questions.dareList.shuffled()
                dareIndex = 0
            }
            truthDareStack.isHidden = true
            randomButton.isHidden = true
            titleLabel.text = "Действие"
        // Рандом
        case 3:
            let randomAction = getActionWithAnimation()
            delayState.throttle {
                self.truthButton.layer.removeAllAnimations()
                self.dareButton.layer.removeAllAnimations()
                self.readyButton.isHidden = false
                self.question.text = self.getRandomQuestion(from: randomAction)
                if randomAction == "dare" {
                    if self.dareIndex != Questions.dareList.count - 1 {
                        self.dareIndex += 1
                    } else {
                        self.randomDare = Questions.dareList.shuffled()
                        self.dareIndex = 0
                    }
                } else {
                    if self.truthIndex != Questions.truthList.count - 1 {
                        self.truthIndex += 1
                    } else {
                        self.randomTruth = Questions.truthList.shuffled()
                        self.truthIndex = 0
                    }
                }
                self.truthDareStack.isHidden = true
                self.randomButton.isHidden = true
            }
        default:
            break
        }
    }
    
    func getRandomQuestion(from action: String) -> String {
        switch action {
        case "dare":
            self.titleLabel.text = "Действие"
            return randomDare[dareIndex]
        case "truth":
            self.titleLabel.text = "Правда"
            return randomTruth[truthIndex]
        default:
            return ""
        }
    }
    
    func firstAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.truthButton.backgroundColor = UIColor(named: "flash")
            self.dareButton.backgroundColor = UIColor(named: "orangeYellow")
        }, completion: nil)
    }
    
    func secondAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.dareButton.backgroundColor = UIColor(named: "flash")
            self.truthButton.backgroundColor = UIColor(named: "orangeYellow")
        }, completion: nil)
    }
    
    // MARK: - воспроизвести анимацию, в зависимости от выбора рандома
    
    func getActionWithAnimation() -> String {
        guard let randomAction = ["dare", "truth"].randomElement() else { return "" }
        switch randomAction {
        case "dare":
            Throttler(minimumDelay: 0.4).throttle {
                self.secondAnimation()
            }
            firstAnimation()
        case "truth":
            Throttler(minimumDelay: 0.4).throttle {
                self.firstAnimation()
            }
            secondAnimation()
        default:
            return randomAction
        }
        return randomAction
    }
    
    func setPlayer(to text: String) -> String {
        let player = players[Int.random(in: 0...players.count - 1)]
        if player == self.player.text {
            return setPlayer(to: text)
        } else {
            return text.replacingOccurrences(of: "*", with: player)
        }
    }
    
    func configureUI() {
        randomPlayers = players.shuffled()
        randomDare = Questions.dareList.shuffled()
        randomTruth = Questions.truthList.shuffled()
        setState(0)
        removeBorder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
}
