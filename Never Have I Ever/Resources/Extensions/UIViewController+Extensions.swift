//
//  UIViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 27.02.2021.
//  Copyright © 2021 medef00. All rights reserved.
//

import UIKit

extension UIViewController {
    final func removeBorder() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    final func showAlert(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        guard let actions = actions else {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
