//
//  CalculatorViewModel.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 28/11/2024.
//

import Foundation
import Combine

struct Result {
    let amountPerPerson: Double
    let totalBill: Double
    let totalTip: Double
}

class CalculatorViewModel {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Int, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        let updateViewPublisher = Publishers.CombineLatest3(input.billPublisher,
                                                            input.tipPublisher,
                                                            input.splitPublisher)
            .flatMap({ [weak self](bill, tip, split) in
                
                let totalTip = self?.getTotalTip(bill: bill, tip: tip) ?? 0
                let totalBill = bill + totalTip
                let amountPerPerson = Double(totalBill/Double(split))
                
                let result = Result(amountPerPerson: amountPerPerson, totalBill: totalBill, totalTip: totalTip)
                
                return Just(result)
            })
            .eraseToAnyPublisher()
                
        return Output(updateViewPublisher: updateViewPublisher)
    }
    
    private func getTotalTip(bill: Double, tip: Int) -> Double {
        var totalTip: Double = 0
        
        switch tip {
        case 10:
            totalTip = bill * 0.1
        case 15:
            totalTip = bill * 0.15
        case 20:
            totalTip = bill * 0.2
        default:
            totalTip = Double(tip)
        }
        
        
        return totalTip
    }
}
