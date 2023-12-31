//
//  MessageTableViewCell.swift
//  Bet365Task
//
//  Created by Faraz on 28/12/2023.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var messageLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Public
    
    public func setCellData(message: String) {
        
        messageLbl.text = message
    }

}
