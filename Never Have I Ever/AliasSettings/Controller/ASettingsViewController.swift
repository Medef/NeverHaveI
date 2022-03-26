//
//  ASettingsViewController.swift
//  Never Have I Ever
//
//  Created by Medef on 08.08.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

class ASettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var teams: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeBorder()
    }
}

extension ASettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WordsCell", for: indexPath) as! WordsCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MissWordCell", for: indexPath) as! MissWordCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 106
        case 1:
            return 106
        case 2:
            return 64
        default:
            return 106
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
