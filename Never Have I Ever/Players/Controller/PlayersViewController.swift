//
//  TruthOrDareViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 03.05.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playButton: UIButton!
    
    private var players: [String] = []
    var choosenGame: GameType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: PlayerCell.id, bundle: Bundle.main), forCellWithReuseIdentifier: PlayerCell.id)
        playButton.layer.cornerRadius = 8
        removeBorder()
    }
    
    @IBAction func addPlayer(_ sender: UIButton) {
        let alert = UIAlertController(title: "Добавьте игрока", message: "", preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.delegate = self
            textField.placeholder = "Введите имя"
            textField.autocapitalizationType = .sentences
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (alertAction) in
            guard let name = alert.textFields?[0].text, name != "" else { return }
            self?.players.append(name)
            self?.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        if players.count > 1 {
            switch choosenGame {
            case .truthOrDare:
                performSegue(withIdentifier: "TruthOrDareViewController", sender: self)
            default:
                performSegue(withIdentifier: "ASettingsViewController", sender: self)
            }
        } else {
            showAlert(title: "Мало игроков ☹️", message: "Игроков должно быть минимум 2")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TruthOrDareViewController" {
            let vc = segue.destination as? TruthOrDareViewController
            vc?.players = players
        } else {
            let vc = segue.destination as? ASettingsViewController
            vc?.teams = players
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
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.id, for: indexPath) as! PlayerCell
        cell.name.text = players[indexPath.row]
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteRow(sender: )), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 61)
    }
    
    @objc func deleteRow(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        players.remove(at: indexPath.row)
        
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
        }) { (finished) in
            self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
        }
    }
    
}
