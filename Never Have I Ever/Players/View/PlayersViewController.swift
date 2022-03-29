//
//  TruthOrDareViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 03.05.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            PlayerCell.register(collectionView)
        }
    }
    @IBOutlet private weak var playButton: UIButton! {
        didSet {
            playButton.layer.cornerRadius = 8
        }
    }
    
    var viewModel: PlayersViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeBorder()
    }
    
    @IBAction func addPlayer(_ sender: UIButton) {
        let alert = UIAlertController(title: "Добавьте игрока", message: "", preferredStyle: .alert)
        alert.addTextField { (textField : UITextField) -> Void in
            textField.delegate = self
            textField.placeholder = "Введите имя"
            textField.autocapitalizationType = .sentences
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (alertAction) in
            guard let name = alert.textFields?[0].text, name != "" else { return }
            self?.viewModel.addPlayer(name)
            self?.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        viewModel.prepareGameToStart { [unowned self] success in
            if success {
                switch viewModel.gameType {
                case .truthOrDare:
                    performSegue(withIdentifier: "TruthOrDareViewController", sender: nil)
                case .alias:
                    performSegue(withIdentifier: "ASettingsViewController", sender: nil)
                case .neverI:
                    break
                }
            } else {
                showAlert(title: "Мало игроков ☹️", message: "Игроков должно быть минимум 2")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TruthOrDareViewController" {
            if let vc = segue.destination as? TruthOrDareViewController {
                // TODO: - Вместо players передавать во viewModel
                vc.players = viewModel.players
            }
        } else {
            if let vc = segue.destination as? ASettingsViewController {
                // TODO: - Вместо teams передавать во viewModel
                vc.teams = viewModel.players
            }
        }
    }
    
}

extension PlayersViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 16
    }
}

extension PlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.id, for: indexPath) as! PlayerCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        cell.viewModel.deleteDidSelect = { [unowned self] indexPath in
            viewModel.removePlayer(at: indexPath)
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [indexPath])
            }) { (finished) in
                collectionView.reloadData()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 61)
    }
}
