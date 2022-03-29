//
//  ViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 01.03.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class NeverIViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var cardView: UIView!
    
    private let throttler = Throttler(minimumDelay: 0.7)
    private var viewModel: NeverIViewModelProtocol!
    
    enum Direction {
        case back
        case forward
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        removeBorder()
    }
    
    @IBAction func next(_ sender: UIButton) {
        nextQuestionDidSelect()
    }
    
    @IBAction func back(_ sender: UIButton) {
        viewModel.preparePreviousQuestion { [unowned self] success in
            if success { animateCard(withDuration: 0.5, text: viewModel.currentQuestion, direction: .back) }
        }
    }
    
    // MARK: - анимация карточки
    private func animateCard(withDuration duration: TimeInterval, text: String, direction: Direction) {
        UIView.animate(withDuration: duration) { [unowned self] in
            centerConstraint.constant = direction == .back ? cardView.frame.width + 48 : -cardView.frame.width - 48
            view.layoutIfNeeded()
        }
        
        titleLabel.text = viewModel.titleForQuestion
        
        throttler.throttle { [unowned self] in
            questionLabel.text = text
            UIView.animate(withDuration: duration) { [unowned self] in
                centerConstraint.constant = 0
                view.layoutIfNeeded()
            }
        }
    }
    
    private func nextQuestionDidSelect() {
        viewModel.prepareNextQuestion { [unowned self] questionsOver in
            if questionsOver {
                showAlert(title: "Упс!", message: "Увы, но все вопросы закончились😔\nНажмите ОК, чтобы начать сначала", actions: [
                    UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (action: UIAlertAction) in
                        questionLabel.text = viewModel.currentQuestion
                        titleLabel.text = viewModel.titleForQuestion
                    })
                ])
            } else {
                animateCard(withDuration: 0.5, text: viewModel.currentQuestion, direction: .forward)
            }
        }
    }
    
    // MARK: - конфигурация viewDidLoad
    
    private func configureUI() {
        viewModel = NeverIViewModel()
        questionLabel.text = viewModel.currentQuestion
        titleLabel.text = viewModel.titleForQuestion
        addSwipes()
    }
    
    private func addSwipes() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        switch gesture.direction {
        case .right:
            viewModel.preparePreviousQuestion { [unowned self] success in
                if success { animateCard(withDuration: 0.5, text: viewModel.currentQuestion, direction: .back) }
            }
        break
        case .left:
            nextQuestionDidSelect()
        default:
            break
        }
    }
}

