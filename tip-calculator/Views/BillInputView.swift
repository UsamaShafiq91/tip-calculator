//
//  BillInputView.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    
    private lazy var headerView: HeaderView = {
       let header = HeaderView(topText: "Enter",
                               bottomText: "your bill")
        
        return header
    }()
    
    private lazy var textFieldContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var currencySymbolLabel: UILabel = {
        let label = UILabel()
        
        label.text = "$"
        label.font = ThemeFont.bold(ofSize: 24)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        textField.font = ThemeFont.demiBold(ofSize: 28)
        textField.keyboardType = .decimalPad
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        
        toolbar.items = [doneButton]
        
        textField.inputAccessoryView = toolbar

        return textField
    }()
    
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupObserver()
    }
    
    func setupView() {
        setupHeaderView()
        setupTextFieldContainerView()
    }
    
    private func setupHeaderView() {
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(68)
        }
    }
    
    private func setupTextFieldContainerView() {
        self.addSubview(textFieldContainerView)
        
        textFieldContainerView.snp.makeConstraints {
            $0.leading.equalTo(headerView.snp.trailing).offset(16)
            $0.top.bottom.trailing.equalToSuperview()
        }

        setupCurrencyLabel()
        setupTextfield()
    }
    
    private func setupCurrencyLabel() {
        textFieldContainerView.addSubview(currencySymbolLabel)
        
        currencySymbolLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    private func setupTextfield() {
        textFieldContainerView.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(currencySymbolLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
    
    private func setupObserver() {
        textField.textPublisher.sink(receiveValue: { value in
            self.billSubject.send(Double(value ?? "0") ?? 0)
        })
        .store(in: &cancellable)
    }
}
