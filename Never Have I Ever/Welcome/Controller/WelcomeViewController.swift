//
//  WelcomeViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 06.03.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var aboutButton: UIButton!
    @IBOutlet private weak var message: UILabel!
    
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        removeBorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        message.frame = CGRect(x: 0, y: 525.5, width: 530, height: 21)
        counter = 0
        message.isHidden = true
    }
    
    // MARK: - Добавляем фичу Настя + Женя = ❤️
    @objc private func showMessage() {
        counter += 1
        if counter == 10 {
            message.isHidden = false
            counter = 0
            UIView.animate(withDuration: 8.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
                self.message.center = CGPoint(x: 0 - self.message.bounds.size.width / 2, y: self.message.center.y)
            })
        } else if counter == 1 {
            message.isHidden = true
        }
    }
    
    private func addFeature() {
        mainImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMessage)))
    }
    
    private func configureUI() {
        message.isHidden = true
        addFeature()
    }

}
