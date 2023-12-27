//
//  GridViewController.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import UIKit
import Combine

class GridViewController: UIViewController {

    /// set of publishers to prevent them being deallocated
    public var cancellables = [AnyCancellable]()
    
    @IBOutlet private weak var mainTable: UITableView!
    private var tableCntrl: TableCntrl!

    
    let viewModel = GridViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        modelSinks()
        
        viewModel.getSnapShot()
        
        repeating()
    }
    
    private func setupView() {
        
        tableCntrl = TableCntrl(owner: self, model: viewModel, table: mainTable)
        
        self.view.backgroundColor = .white
        self.title = "Grid View"
    }
    
    private func repeating() {

        DispatchQueue.main.asyncAfter(deadline: .now() + (viewModel.delayTimes.isEmpty ? 5.0 : (viewModel.delayTimes[viewModel.delayTimesIndex])/1000 )) {[weak self]  in
            
            guard let self = self else {return}
            
            if (self.viewModel.delayTimes.isEmpty ) {
                
                self.viewModel.getDeltas()
            }else {
                
                self.viewModel.processDeltas()
                
                if self.viewModel.delayTimesIndex < viewModel.delayTimes.count - 1 {
                    
                    self.viewModel.delayTimesIndex += 1

                }else  {
                    
                    self.viewModel.delayTimesIndex = 0
                }
            }

            self.repeating()
        }
    }
    
    func modelSinks() {
        
        viewModel.$finData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                
                self?.mainTable.reloadData()
            }
            .store(in: &cancellables)
    }
}
