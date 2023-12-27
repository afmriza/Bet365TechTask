//
//  Extensions.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import Foundation
import UIKit

// MARK: - Extensions

extension UIViewController {
    
    static func instanceFromNib() -> Self {
        
        return Self.init(nibName: kNibName, bundle: .main)
    }
    
    static var kNibName: String {
        
        return String(describing: self)
    }
}

public extension UITableViewCell {
    
    static var kCellId: String {
        
        return String(describing: self)
    }
}

extension UITableView {
    
    func smartRegister(cell: UITableViewCell.Type) {
        
        register(UINib(nibName: cell.kCellId, bundle: .main), forCellReuseIdentifier: cell.kCellId)
    }
}

