//
//  DataService.swift
//  Bet365Task
//
//  Created by Faraz on 27/12/2023.
//

import Foundation

class DataService {
    
    func loadCSV(csvFilePath: String, skipHeader: Bool)  -> ([FinancialDataObj], [Double]) {
        
        var csvData = [FinancialDataObj]()
        var delayTimes = [Double]()
        
        // Read CSV content from file
        guard let content = try? String(contentsOfFile: csvFilePath, encoding: .utf8) else {
            
            return ([], [])
        }
        
        var rows = content.components(separatedBy: "\n")
        
        if skipHeader {
            
            rows.removeFirst()
            rows.removeLast()
        }
        
        for row in rows {
            
            let columns = row.components(separatedBy: ",")
            
            if columns.count == 6 {
                
                let finDataItem = FinancialDataObj(
                    name: columns[0],
                    companyName: columns[1],
                    price:  Float(columns[2]),
                    change:  Float(columns[3]),
                    percentChange:  columns[4],
                    marketCap:  columns[5].replacingOccurrences(of: "\r", with: "")
                )
                
                csvData.append(finDataItem)
            } else {
                
                // delay time
                delayTimes.append(Double(columns[0].filter({$0.isNumber})) ?? 0.0)
            }

        }
        
        return (csvData, delayTimes.dropLast())
    }
}
