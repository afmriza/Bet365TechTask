//
//  DataModels.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import Foundation

struct FinancialDataObj: Codable, Equatable {
    
    var name: String?
    var companyName: String?
    var price: Float?
    var change: Float?
    var percentChange: String?
    var marketCap: String?
    var isUpdated: Bool = false
    
    
    mutating func seedValues(item: FinancialDataObj) {
        
        self.name = item.name
        self.companyName = item.companyName
        self.marketCap = item.marketCap
        
        if price == nil {
            
            self.price = item.price
        }
        
        if change == nil {
            
            self.change = item.change
        }
        
        if percentChange?.isEmpty ?? false {
            
            self.percentChange = item.percentChange
        }
        
        self.isUpdated = self != item
    }
    
    static func ==(lhs: FinancialDataObj, rhs: FinancialDataObj) -> Bool {
        
        return lhs.name == rhs.name && lhs.companyName == rhs.companyName && lhs.price == rhs.price && lhs.change == rhs.change && lhs.percentChange == rhs.percentChange && lhs.marketCap == rhs.marketCap
    }
}
