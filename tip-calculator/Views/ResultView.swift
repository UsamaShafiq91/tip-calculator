//
//  ResultView.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit

class ResultView: UIView {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Total per person"
        label.font = ThemeFont.demiBold(ofSize: 18)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var amountPerPersonLabel: UILabel = {
        let label = UILabel()
        
        let text = NSMutableAttributedString(string: "$0", 
                                             attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttribute(.font,
                          value: ThemeFont.bold(ofSize: 24),
                          range: NSRange(location: 0, length: 1))
        
        label.attributedText = text
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view1 = UIView()
        
        view1.backgroundColor = ThemeColor.separator
        
        return view1
    }()
    
    private var totalBillAmountView = AmountView(title: "Total bill",
                                   alignment: .left)
    private var totalTipAmountView = AmountView(title: "Total tip",
                               alignment: .right)
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalBillAmountView,
            UIView(),
            totalTipAmountView
        ])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            separatorView,
            hStackView
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        self.addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        self.applyShadow(offset: CGSize(width: 0, height: 3),
                         color: .black,
                         radius: 12,
                         opacity: 0.1)
    }
    
    func updateResult(result: Result) {
        updateAmountPerPerson(amountPerPerson: result.amountPerPerson)
        totalBillAmountView.updateAmount(amount: result.totalBill)
        totalTipAmountView.updateAmount(amount: result.totalTip)
    }
    
    private func updateAmountPerPerson(amountPerPerson: Double) {
        let text = NSMutableAttributedString(string: "$\(amountPerPerson.formattedValue)",
                                             attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttribute(.font,
                          value: ThemeFont.bold(ofSize: 24),
                          range: NSRange(location: 0, length: 1))
        
        amountPerPersonLabel.attributedText = text
    }
}
