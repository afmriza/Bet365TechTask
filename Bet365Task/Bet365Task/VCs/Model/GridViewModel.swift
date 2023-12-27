//
//  GridViewModel.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import Foundation

class GridViewModel {
      
    /// a published array of financial data objs to update UI
    @Published private(set) var finData: [FinancialDataObj] = []

    
    /// an array to hold values from delta csv file
    private var deltas = [FinancialDataObj]()
    
    /// an array to hold delay times
    private(set) var delayTimes = [Double]()
    
    /// a temporary array to hold values from delta csv file
    private var tempDeltaData = [FinancialDataObj]()
    private let dataService = DataService()
    
    public var delayTimesIndex = 0
    
    public func getSnapShot() {
        
        guard let filePath = Bundle.main.path(forResource: "snapshot", ofType: "csv") else {
            
            return
        }
        
        finData = dataService.loadCSV(csvFilePath: filePath, skipHeader: true).0
    }
    
    public func getDeltas() {
        
        guard let filePath = Bundle.main.path(forResource: "deltas", ofType: "csv") else {
            
            return
        }
        
        let (deltas, delayTimes) = dataService.loadCSV(csvFilePath: filePath, skipHeader: false)

        self.deltas = deltas
        self.delayTimes = delayTimes
        
        tempDeltaData = deltas
        
        processDeltas()
    }
    
    @objc
    public func processDeltas() {
        
        if (tempDeltaData.isEmpty) {
            
            // assign values from property rather than reloading csv file
            tempDeltaData = deltas
        }
        
        // take the fist 10
        var firstTen = Array(tempDeltaData.prefix(10))
        
        for (index, item) in finData.enumerated() {
            
            // populate missing fields on delta
            firstTen[index].seedValues(item: item)
        }
        
        finData = firstTen
        tempDeltaData.removeFirst(10)
        
    }
}
