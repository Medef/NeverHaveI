//
//  String.swift
//  Never Have I Ever
//
//  Created by Medef on 01.03.2020.
//  Copyright © 2020 medef00. All rights reserved.
//

import UIKit

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript(bounds: CountableClosedRange<Int>) -> String {
        let lowerBound = max(0, bounds.lowerBound)
        guard lowerBound < self.count else { return "" }
        
        let upperBound = min(bounds.upperBound, self.count-1)
        guard upperBound >= 0 else { return "" }
        
        let i = index(startIndex, offsetBy: lowerBound)
        let j = index(i, offsetBy: upperBound-lowerBound)
        
        return String(self[i...j])
    }
    
    subscript(bounds: CountableRange<Int>) -> String {
        let lowerBound = max(0, bounds.lowerBound)
        guard lowerBound < self.count else { return "" }
        
        let upperBound = min(bounds.upperBound, self.count)
        guard upperBound >= 0 else { return "" }
        
        let i = index(startIndex, offsetBy: lowerBound)
        let j = index(i, offsetBy: upperBound-lowerBound)
        
        return String(self[i..<j])
    }
}
