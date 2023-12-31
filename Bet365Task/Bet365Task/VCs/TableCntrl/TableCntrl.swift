//
//  TableCntrl.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import Foundation

import UIKit

class TableCntrl: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    enum Sections: Int, CaseIterable {
        
        case EGraphView
        case EGrid
        case ENoDataMessage
    }
    
    weak var owner: UIViewController?
    weak var model: GridViewModel?
    weak var table: UITableView?
    
    var cellsToReg: [UITableViewCell.Type] {
        
        return [GridItemTableViewCell.self,
                GraphTableViewCell.self,
                MessageTableViewCell.self]
    }
    
    
    init(owner: UIViewController, model: GridViewModel, table: UITableView) {
        
        self.owner = owner
        self.model = model
        self.table = table
        
        super.init()
        
        self.table?.dataSource = self
        self.table?.delegate = self
        
        registerCells()
    }
    
    
    // MARK: - Private
    
    private func registerCells() {
        
        cellsToReg.forEach({table?.smartRegister(cell: $0.self)})
    }
    
    // MARK: - Table View Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return Sections.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let model = model else { return 0}
        
        let section = Sections(rawValue: section)!
        switch section {
            
        case .EGraphView:
            
            return model.showGraphView ? 1 : 0
        case .EGrid:
            
            return model.finData.count
        case .ENoDataMessage:
            
            return model.finData.isEmpty ? 1 : 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = model else { return UITableViewCell() }
        
        let section = Sections(rawValue: indexPath.section)!
        switch section {
        case .EGraphView:
            var title: String?
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GraphTableViewCell.kCellId, for: indexPath) as! GraphTableViewCell
            
            if let selIndexforGraph = model.selecdIndexforGraph {
                
               title = model.finData[selIndexforGraph].companyName
            }
            
            cell.setCellData(price: model.graphData, title: title)
            return cell
            
        case .EGrid:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: GridItemTableViewCell.kCellId, for: indexPath) as! GridItemTableViewCell
            
            cell.setCellData(showHeader: indexPath.row == 0, data: model.finData[indexPath.row])
            
            return cell
            
        case .ENoDataMessage:
            
            let cell =  tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.kCellId, for: indexPath) as! MessageTableViewCell
            
            cell.setCellData(message: "No data available")
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let model = model else { return .leastNonzeroMagnitude }
        
        let section = Sections(rawValue: indexPath.section)!
        switch section {
            
        case .EGraphView:
            
            return model.showGraphView ? GraphTableViewCell.kCellHeight : .leastNonzeroMagnitude
        case .EGrid:
            
            return indexPath.row == 0 ? GridItemTableViewCell.kCellHeightWithHeader : GridItemTableViewCell.kCellHeigthNoHeader
        case .ENoDataMessage:
            
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let model = model else { return }
        
        let section = Sections(rawValue: indexPath.section)!
        switch section {
            
        case .EGraphView:
            
            return
        case .EGrid:
            
            // clear previous values
            if model.selecdIndexforGraph != indexPath.row {
                
                model.graphData.removeAll()
                model.selecdIndexforGraph = indexPath.row
                model.showGraphView = true
            } else {
                
                // show/hide graph
                model.showGraphView.toggle()
            }
            
            model.populateGraphData()
        case .ENoDataMessage:
            
            return
        }
    }
}
