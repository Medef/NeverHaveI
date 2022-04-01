//
//  TruthOrDareViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 03.05.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class TruthOrDareViewController: UIViewController {
    
    @IBOutlet private weak var playerLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var question: UILabel!
    @IBOutlet private weak var readyButton: UIButton!
    @IBOutlet private weak var truthDareStack: UIStackView!
    @IBOutlet private weak var truthButton: UIButton!
    @IBOutlet private weak var dareButton: UIButton!
    @IBOutlet private weak var randomButton: UIButton!
    
    /// Animation duration
    private let delay = Throttler(minimumDelay: 3)
    var viewModel: TruthOrDareViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func truth(_ sender: UIButton) {
        updateUI(to: .truth)
    }
    
    @IBAction func dare(_ sender: UIButton) {
        updateUI(to: .dare)
    }
    
    @IBAction func chooseRandom(_ sender: UIButton) {
        updateUI(to: .random)
    }
    
    @IBAction func ready(_ sender: UIButton) {
        updateUI(to: .initial)
    }
    
    private func configureUI() {
        updateUI(to: .initial)
        removeBorder()
    }
    
    // MARK: - изменение состояния игры
    private func updateUI(to state: TruthOrDareState) {
        
        question.text = viewModel.getQuestion(for: state)
        titleLabel.text = state.rawValue
        
        switch state {
        case .initial:
            playerLabel.text = viewModel.currentPlayer
            
            viewModel.nextPlayer()
            
            readyButton.isHidden = true
            truthDareStack.isHidden = false
            randomButton.isHidden = false
            dareButton.backgroundColor = Color.yellow
            truthButton.backgroundColor = Color.yellow
        case .truth, .dare:
            
            viewModel.updateQuestions(state)
            
            readyButton.isHidden = false
            truthDareStack.isHidden = true
            randomButton.isHidden = true
        case .random:
            
            let selectedButton = viewModel.selectButton { [unowned self] in
                animateButtons()
            }
            
            // Задерживаем выполнение действий, пока работает анимация
            delay.throttle { [unowned self] in
                truthButton.layer.removeAllAnimations()
                dareButton.layer.removeAllAnimations()
                
                truthButton.backgroundColor = selectedButton == .truth ? Color.red : Color.yellow
                dareButton.backgroundColor = selectedButton == .dare ? Color.red : Color.yellow
                
                // Задерживаем установку вопроса
                Throttler(minimumDelay: 1).throttle { [unowned self] in
                    question.text = viewModel.getQuestion(for: selectedButton)
                    viewModel.updateQuestions(selectedButton)
                    updateUI(to: selectedButton)
                }
            }
        }
    }
    
    // MARK: - Анимация выбора кнопки
    private func animateButtons() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear, .repeat, .autoreverse]) { [unowned self] in
            truthButton.backgroundColor = Color.red
            UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveLinear, .repeat, .autoreverse]) { [unowned self] in
                dareButton.backgroundColor = Color.red
            }
        }
    }
}
