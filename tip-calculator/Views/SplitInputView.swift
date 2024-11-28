//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    
    private lazy var headerView: HeaderView = {
       let header = HeaderView(topText: "Choose",
                               bottomText: "your tip")
        
        return header
    }()
    
    private lazy var decrementButton: UIButton = {
       let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.layer.cornerRadius = 8
        
        button.tapPublisher.flatMap({
            Just(self.splitPublisher.value == 1 ? 1 : (self.splitPublisher.value - 1))
        })
        .assign(to: \.value, on: splitPublisher)
        .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
       let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        button.layer.cornerRadius = 8
        
        button.tapPublisher.flatMap({
            Just(self.splitPublisher.value + 1)
        })
        .assign(to: \.value, on: splitPublisher)
        .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        
        label.text = "1"
        label.textAlignment = .center
        label.font = ThemeFont.bold(ofSize: 20)
        label.backgroundColor = .white
        
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        decrementButton,
        quantityLabel,
        incrementButton
       ])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let splitPublisher: CurrentValueSubject<Int, Never> = .init(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitPublisher.removeDuplicates().eraseToAnyPublisher()
    }
    private var cancellable = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setupHeaderView()
        setupStackView()
    }
    
    private func setupHeaderView() {
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(68)
        }
    }
    
    private func setupStackView() {
        self.addSubview(hStackView)
        
        hStackView.snp.makeConstraints {
            $0.leading.equalTo(headerView.snp.trailing).offset(16)
            $0.top.bottom.trailing.equalToSuperview()
        }
    }
    
    private func setupObserver() {
        splitPublisher.sink(receiveValue: {[weak self] value in
            self?.quantityLabel.text = "\(value)"
        })
        .store(in: &cancellable)
    }
}
