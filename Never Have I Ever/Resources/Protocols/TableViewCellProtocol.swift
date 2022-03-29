//
//  TableViewCellProtocol.swift
//  Never Have I Ever
//
//  Created by Medef on 28.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import UIKit

protocol TableViewCellProtocol {
    static var cellHeight: CGFloat { get set }
    static var coefficient: CGFloat? { get }
    
    static var id: String { get }
    
    static func register(tableView: UITableView)
    static func getCell<CellType: UITableViewCell>(tableView: UITableView) -> CellType?
}

extension TableViewCellProtocol {
    
    static var coefficient: CGFloat? {
        return nil
    }
    
    static func register(tableView: UITableView) {
        tableView.register(UINib(nibName: self.id, bundle: nil), forCellReuseIdentifier: self.id)
    }
    
    static func getCell<CellType>(tableView: UITableView) -> CellType? {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: self.id) as? CellType else {
            return nil
        }
        return cell
    }
    
    static var id: String {
        return String(describing: self)
    }
    
}

