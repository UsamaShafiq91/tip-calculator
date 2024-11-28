//
//  HeaderView.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    let topText: String
    let bottomText: String
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        
        label.text = topText
        label.font = ThemeFont.bold(ofSize: 18)
        
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        
        label.text = bottomText
        label.font = ThemeFont.regular(ofSize: 16)
        
        return label
    }()
    
    private let topSpacer = UIView()
    private let bottomSpacer = UIView()

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacer,
            topLabel,
            bottomLabel,
            bottomSpacer
        ])
        
        stackView.axis = .vertical
        stackView.spacing = -4
        
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(topText: String, bottomText: String) {
        self.topText = topText
        self.bottomText = bottomText
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    func setupView() {
        self.addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        topSpacer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(bottomSpacer)
        }
    }
    
}
