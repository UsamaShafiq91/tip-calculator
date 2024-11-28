//
//  TipInputView.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import Foundation
import UIKit
import Combine
import CombineCocoa


enum TipPercent: Int {
    case ten = 10
    case fifteen = 15
    case twenty = 20
}

class TipInputView: UIView {
    
    private lazy var headerView: HeaderView = {
       let header = HeaderView(topText: "Choose",
                               bottomText: "your tip")
        
        return header
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildPercentTipButton(title: "10%")
        
        button.tapPublisher.flatMap({
            Just(10)
        })
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var fifteenPercentButton: UIButton = {
        let button = buildPercentTipButton(title: "15%")
        
        button.tapPublisher.flatMap({
            Just(15)
        })
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildPercentTipButton(title: "20%")
        
        button.tapPublisher.flatMap({
            Just(20)
        })
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var customPercentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.layer.cornerRadius = 8

        let text = NSMutableAttributedString(string: "Custom",
                                             attributes: [.font: ThemeFont.bold(ofSize: 20),
                                                          .foregroundColor: UIColor.white])
        
        button.setAttributedTitle(text, for: .normal)
        
        button.tapPublisher.sink(receiveValue: {[weak self] _ in
            self?.customTipButtonTapped()
        })
        .store(in: &cancellable)
        
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        tenPercentButton,
        fifteenPercentButton,
        twentyPercentButton
       ])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        hStackView,
        customPercentButton
       ])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let tipSubject: CurrentValueSubject<Int, Never> = .init(0)
    var valuePublisher: AnyPublisher<Int, Never> {
        return tipSubject.eraseToAnyPublisher()
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
    
    private func buildPercentTipButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.layer.cornerRadius = 8

        let text = NSMutableAttributedString(string: title,
                                             attributes: [.font: ThemeFont.bold(ofSize: 20),
                                                          .foregroundColor: UIColor.white])
        text.addAttribute(.font,
                          value: ThemeFont.demiBold(ofSize: 14),
                          range: NSRange(location: 2, length: 1))
        
        button.setAttributedTitle(text, for: .normal)
        
        return button
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
        self.addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.leading.equalTo(headerView.snp.trailing).offset(16)
            $0.top.bottom.trailing.equalToSuperview()
        }
    }
    
    private func customTipButtonTapped() {
        let alert = UIAlertController(title: "Tip",
                                      message: "Enter custom tip",
                                      preferredStyle: .alert)
        
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Done",
                                      style: .default,
                                      handler: {_ in 
            guard let textValue = alert.textFields?.first?.text, let intValue = Int(textValue) else { return }
            
            self.tipSubject.send(intValue)
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))
        
        self.parentController?.present(alert, animated: false)
    }
    
    private func setupObserver() {
        tipSubject.sink(receiveValue: {[weak self] value in
            self?.resetButtons()
            
            switch value {
            case 10:
                self?.tenPercentButton.backgroundColor = ThemeColor.secondary
            case 15:
                self?.fifteenPercentButton.backgroundColor = ThemeColor.secondary
            case 20:
                self?.twentyPercentButton.backgroundColor = ThemeColor.secondary
            default:
                if value != 0 {
                    let title = "$\(value)"
                    let text = NSMutableAttributedString(string: title,
                                                         attributes: [.font: ThemeFont.bold(ofSize: 20),
                                                                      .foregroundColor: UIColor.white])
                    text.addAttribute(.font,
                                      value: ThemeFont.demiBold(ofSize: 14),
                                      range: NSRange(location: 2, length: 1))
                    
                    self?.customPercentButton.setAttributedTitle(text, for: .normal)
                    self?.customPercentButton.backgroundColor = ThemeColor.secondary
                }
            }
        })
        .store(in: &cancellable)
    }
    
    private func resetButtons() {
        tenPercentButton.backgroundColor = ThemeColor.primary
        fifteenPercentButton.backgroundColor = ThemeColor.primary
        twentyPercentButton.backgroundColor = ThemeColor.primary
        
        customPercentButton.backgroundColor = ThemeColor.primary
        let text = NSMutableAttributedString(string: "Custom",
                                             attributes: [.font: ThemeFont.bold(ofSize: 20),
                                                          .foregroundColor: UIColor.white])
        
        customPercentButton.setAttributedTitle(text, for: .normal)
    }
}
