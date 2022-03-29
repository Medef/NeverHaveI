//
//  CollectionViewCellProtocol.swift
//  Never Have I Ever
//
//  Created by Medef on 28.03.2022.
//  Copyright © 2022 medef00. All rights reserved.
//

import UIKit

protocol CollectionViewCellProtocol {
    static var coefficient: CGFloat { get }
    static var id: String { get }
    
    static func register(_ collectionView: UICollectionView)
    static func getCell<CellType: UITableViewCell>(_ collectionView: UICollectionView, for indexPath: IndexPath) -> CellType?
    
    static func getSize(width: CGFloat, indent: CGFloat) -> CGSize
    
}

extension CollectionViewCellProtocol {
    
    static func register(_ collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: self.id, bundle: nil), forCellWithReuseIdentifier: self.id)
    }
    
    static func getCell<CellType>(_ collectionView: UICollectionView, for indexPath: IndexPath) -> CellType? {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.id, for: indexPath) as? CellType else {
            return nil
        }
        return cell
    }
    
    static func getSize(width: CGFloat, indent: CGFloat) -> CGSize {
        let cellWidth = width - indent - indent
        return CGSize(width: cellWidth, height: cellWidth * self.coefficient)
    }
    
    static var id: String {
        return String(describing: self)
    }
    
}
