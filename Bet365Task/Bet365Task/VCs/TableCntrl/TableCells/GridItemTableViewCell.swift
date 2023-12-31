//
//  GridItemTableViewCell.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import UIKit

class GridItemTableViewCell: UITableViewCell {
    
    static let kCellHeightWithHeader: CGFloat = 100
    static let kCellHeigthNoHeader: CGFloat = 50
    
    @IBOutlet private weak var headerStack: UIStackView!
    
    @IBOutlet var headerLabels: [UILabel]!
    @IBOutlet var labels: [UILabel]!
    
    
    @IBOutlet weak var labelStack: UIStackView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var companyName: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var change: UILabel!
    @IBOutlet private weak var percentChange: UILabel!
    @IBOutlet private weak var mktCap: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
    }

    // MARK: - Private
    
    private func setupView() {
        
        headerStack.backgroundColor = .gray
        
        for lbl in headerLabels {
            
            lbl.font = .systemFont(ofSize: 14, weight: .bold)
            lbl.textColor = .black
            lbl.textAlignment = .center

        }
        
        for lbl in labels {
            
            lbl.font = .systemFont(ofSize: 12, weight: .medium)
            lbl.textColor = .black
            lbl.textAlignment = .center
            lbl.layer.borderColor = UIColor.black.cgColor
            lbl.layer.borderWidth = 1
        }
    }
    
    override func prepareForReuse() {
        
        change.textColor = .black
        for lbl in labels {
            
            lbl.text = ""
        }
        
        labelStack.backgroundColor = .clear
    }
    
    // MARK: - Public
    
    public func setCellData(showHeader: Bool, data: FinancialDataObj) {
        
        headerStack.isHidden = !showHeader
        
        if !(data.name?.isEmpty ?? false) {
            
            nameLbl.text = data.name
        }

        if !(data.companyName?.isEmpty ?? false) {
            
            companyName.text = data.companyName
        }

        price.text = "\(data.price ?? 0.0)"
        change.text = "\(data.change ?? 0.0)"
        percentChange.text = data.percentChange
        
        if !(data.marketCap?.isEmpty ?? false) {
            
            mktCap.text = data.marketCap
        }

        if data.change ?? 0 < 1 {
            
            change.textColor = .red
        }
        
        labelStack.backgroundColor = data.isUpdated ? .green : .clear
    }
    
}
