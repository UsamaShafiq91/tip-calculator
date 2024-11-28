//
//  LogoView.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit

class LogoView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icCalculatorBW"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        
        let text = NSMutableAttributedString(string: "Mr TIP",
                                             attributes: [.font: ThemeFont.demiBold(ofSize: 16)])
        text.addAttribute(.font, 
                          value: ThemeFont.bold(ofSize: 24),
                          range: NSRange(location: 3, length: 3))
        label.attributedText = text
        
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Calculator"
        label.font = ThemeFont.demiBold(ofSize: 20)
        label.textAlignment = .left
                
        return label
    }()
    
    private lazy var VStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = -4
        
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VStackView
        ])
        
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    private func setupView() {
        self.addSubview(hStackView)
        
        hStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width)
        }
    }
}
