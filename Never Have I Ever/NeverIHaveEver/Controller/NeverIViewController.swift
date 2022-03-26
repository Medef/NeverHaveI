//
//  ViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 01.03.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class NeverIViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    private let throttler = Throttler(minimumDelay: 0.7)
    private var index = 0
    private var randomQuestions: [String] = []
    
    enum Direction {
        case back
        case forward
    }
    
    @IBAction func next(_ sender: UIButton) {
        if index != randomQuestions.count - 1 {
            index += 1
            animateCard(withDuration: 0.5, text: randomQuestions[index], direction: .forward)
        } else {
            showAlert(title: "Упс!", message: "Увы, но все вопросы закончились😔\nНажмите ОК, чтобы начать сначала", actions: [
                UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction) in
                    self?.randomQuestions = Questions.neverIHave.shuffled()
                    self?.index = 0
                    self?.questionLabel.text = self?.randomQuestions[self!.index]
                    self?.changeTitle(at: self!.index)
                })
            ])
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        if index != 0 {
            index -= 1
            animateCard(withDuration: 0.5, text: randomQuestions[index], direction: .back)
        }
    }
    
    // MARK: - анимация карточки
    private func animateCard(withDuration duration: TimeInterval, text: String, direction: Direction) {
        UIView.animate(withDuration: duration) {
            if direction == .back {
                self.centerConstraint.constant = self.cardView.frame.width + 48
            } else {
                self.centerConstraint.constant = -self.cardView.frame.width - 48
            }
            self.view.layoutIfNeeded()
            
        }
        changeTitle(at: index)
        throttler.throttle {
            self.questionLabel.text = text
            UIView.animate(withDuration: duration) {
                self.centerConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Изменение заголовка
    
    private func changeTitle(at index: Int) {
        if randomQuestions[index][0...3] == "было" {
            titleLabel.text = "У меня никогда не..."
        } else {
            titleLabel.text = "Я никогда не..."
        }
    }
    
    // MARK: - конфигурация viewDidLoad
    
    private func configureUI() {
        randomQuestions = Questions.neverIHave.shuffled()
        questionLabel.text = randomQuestions[index]
        changeTitle(at: index)
        addSwipes()
    }
    
    private func addSwipes() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        switch gesture.direction {
        case .right:
            if index != 0 {
                index -= 1
                animateCard(withDuration: 0.5, text: randomQuestions[index], direction: .back)
            }
        break
        case .left:
            if index != randomQuestions.count - 1 {
                index += 1
                animateCard(withDuration: 0.5, text: randomQuestions[index], direction: .forward)
            }
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        removeBorder()
    }
}

