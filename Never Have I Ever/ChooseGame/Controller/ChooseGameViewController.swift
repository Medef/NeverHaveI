//
//  ChooseGameViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 26.07.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit
import FSPagerView

class ChooseGameViewController: UIViewController, ChooseGameCellDelegate {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(UINib(nibName: "ChooseGameCell", bundle: nil), forCellWithReuseIdentifier: ChooseGameCell.id)
        }
    }
    
    func chooseGame(_ index: Int) {
        switch index {
        case 0:
            self.performSegue(withIdentifier: "NeverHaveIEver", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "Players", sender: GameType.truthOrDare)
        case 2:
            self.performSegue(withIdentifier: "Players", sender: GameType.alias)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Players" {
            if let vc = segue.destination as? PlayersViewController {
                vc.choosenGame = sender as? GameType
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        pagerView.itemSize = CGSize(width: self.view.frame.width - 80, height: 375)
        removeBorder()
    }
}

extension ChooseGameViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: ChooseGameCell.id, at: index) as! ChooseGameCell
        cell.delegate = self
        cell.index = index
        switch index {
        case 0:
            cell.title.text = "Я никогда не..."
            cell.descriptionLabel.text = "Правила игры: игрок зачитывает вопрос, например: «Я никогда не пробовал собачью или кошачью еду», — все, кто пробовал, пьют. Само собой за этим должна последовать история о том, как это произошло."
        case 1:
            cell.title.text = "Правда или Действие"
            cell.descriptionLabel.text = "Правила игры: игрок зачитывает вопрос, например: «Ты когда-нибудь прыгал с парашютом?», — и отвечает на него. Само собой, если выпадает действие, то игрок его выполняет."
        case 2:
            cell.title.text = "Алиас"
            cell.descriptionLabel.text = "Правила игры: игрок каждой команды объясняет как можно больше слов, а команда отгадывает. Нельзя использовать однокоренные или иностранные слова для объяснения. Побеждает команда, набравшая больше всего очков"
        default:
            break
        }
        return cell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
}

protocol ChooseGameCellDelegate {
    func chooseGame(_ index: Int)
}

enum GameType {
    case truthOrDare
    case neverI
    case alias
}
