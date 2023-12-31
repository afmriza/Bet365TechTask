//
//  GraphTableViewCell.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import UIKit

class GraphTableViewCell: UITableViewCell {
    
    static let kCellHeight: CGFloat = 300
            
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var graphViewWidth: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var priceLbl: UILabel!
    
    private let graphViewInitialWidth = 900.0
    private let stepX = 40
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public
    
    public func setCellData(price: [Float], title: String?) {
        
        titleLbl.text = title
        graphView.graphPoints = price
        
        let newWidth = CGFloat((price.count - 1) * stepX + stepX)
        if newWidth > graphViewWidth.constant {
            
            graphViewWidth.constant = newWidth
        } else {
            
            graphViewWidth.constant = graphViewInitialWidth
        }
        
        if let currentPrice = price.last {
            
            priceLbl.text = "Current Price \(currentPrice)"
        }
    }
}
