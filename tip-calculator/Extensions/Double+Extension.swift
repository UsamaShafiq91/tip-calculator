//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 28/11/2024.
//

import Foundation

extension Double {
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        formatter.numberStyle = .decimal
        
        return formatter.string(from: self as NSNumber) ?? ""
    }
    
}
