//
//  AmountView.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit

class AmountView: UIView {
    private let title: String
    private let alignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = title
        label.font = ThemeFont.regular(ofSize: 18)
        label.textColor = ThemeColor.text
        label.textAlignment = alignment
        
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        
        let text = NSMutableAttributedString(string: "$0",
                                             attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttribute(.font,
                          value: ThemeFont.bold(ofSize: 16),
                          range: NSRange(location: 0, length: 1))
        
        label.textAlignment = alignment
        label.attributedText = text
        label.textColor = ThemeColor.primary
        
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    init(title: String, alignment: NSTextAlignment) {
        
        self.title = title
        self.alignment = alignment
        
        super.init(frame: .zero)

        setupView()
    }
    
    func setupView() {
        self.addSubview(vStackView)
        
        vStackView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func updateAmount(amount: Double) {
        let text = NSMutableAttributedString(string: "$\(amount.formattedValue)",
                                             attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttribute(.font,
                          value: ThemeFont.bold(ofSize: 16),
                          range: NSRange(location: 0, length: 1))
        
        amountLabel.attributedText = text
    }
}
