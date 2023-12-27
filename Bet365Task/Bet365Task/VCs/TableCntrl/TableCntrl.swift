//
//  TableCntrl.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import Foundation

import UIKit

class TableCntrl: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    weak var owner: UIViewController?
    weak var model: GridViewModel?
    weak var table: UITableView?
    
    var cellsToReg: [UITableViewCell.Type] {
        
        return [GridItemTableViewCell.self]
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let model = model else { return 0}
        
        return model.finData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = model else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: GridItemTableViewCell.kCellId, for: indexPath) as! GridItemTableViewCell
        
        cell.setCellData(showHeader: indexPath.row == 0, data: model.finData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return indexPath.row == 0 ? 100 : 50
    }
}
