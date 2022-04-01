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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeBorder()
    }
    
}
