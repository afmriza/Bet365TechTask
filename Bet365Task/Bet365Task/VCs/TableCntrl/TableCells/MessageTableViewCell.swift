//
//  MessageTableViewCell.swift
//  Bet365Task
//
//  Created by Faraz on 28/12/2023.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    static let kCellHeight: CGFloat = 60.0
    
    @IBOutlet private weak var messageLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // MARK: - Public
    
    public func setCellData(message: String) {
        
        messageLbl.text = message
    }

}
