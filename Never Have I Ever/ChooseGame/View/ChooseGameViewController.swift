//
//  ChooseGameViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 26.07.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit
import FSPagerView

class ChooseGameViewController: UIViewController {
    
    @IBOutlet private weak var pagerView: FSPagerView! {
        didSet {
            pagerView.register(UINib(nibName: ChooseGameCell.id, bundle: nil), forCellWithReuseIdentifier: ChooseGameCell.id)
        }
    }
    private var viewModel: ChooseGameViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChooseGameViewModel()
        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        pagerView.itemSize = CGSize(width: view.frame.width - 80, height: 375)
        removeBorder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Players" {
            if let vc = segue.destination as? PlayersViewController {
                vc.viewModel = PlayersViewModel(sender as! GameType)
            }
        }
    }
}

extension ChooseGameViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.numberOfRows
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: ChooseGameCell.id, at: index) as! ChooseGameCell
        cell.viewModel = viewModel.cellViewModel(at: index)
        cell.viewModel.gameDidSelect = { [unowned self] gameType in
            switch gameType {
            case .neverI:
                performSegue(withIdentifier: "NeverHaveIEver", sender: gameType)
            case .truthOrDare, .alias:
                performSegue(withIdentifier: "Players", sender: gameType)
            }
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}
