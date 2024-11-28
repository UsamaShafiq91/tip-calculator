//
//  ViewController.swift
//  tip-calculator
//
//  Created by UsamaShafiq on 22/11/2024.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class CalculatorViewController: UIViewController {
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    let calculatorViewModel = CalculatorViewModel()
    var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let gesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(gesture)
        
        return gesture.tapPublisher.flatMap({_ in
            Just(())
        })
        .eraseToAnyPublisher()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        setupViewModel()
        setupObserver()
    }
    
    func setupObserver() {
        viewTapPublisher.sink(receiveValue: {
            self.view.endEditing(true)
        })
        .store(in: &cancellables)
    }
    
    func setupViewModel() {
        let input = CalculatorViewModel.Input(billPublisher: billInputView.valuePublisher,
                                              tipPublisher: tipInputView.valuePublisher,
                                              splitPublisher: splitInputView.valuePublisher)
        
        let output = calculatorViewModel.transform(input: input)
        
        output.updateViewPublisher.sink(receiveValue: {[unowned self] result in
            self.resultView.updateResult(result: result)
        })
        .store(in: &cancellables)
    }

    func setupView() {
        view.backgroundColor = ThemeColor.background
        setupStackView()
        setupLogoView()
        setupResultView()
        setupBillInputView()
        setupSplitInputView()
    }
    
    func setupStackView() {
        view.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-24).priority(.low)
        }
    }
    
    func setupLogoView() {
        logoView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    func setupResultView() {
        resultView.snp.makeConstraints {
            $0.height.equalTo(224)
        }
    }
    
    func setupBillInputView() {
        billInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    func setupTipInputView() {
        tipInputView.snp.makeConstraints {
            $0.height.equalTo(128)
        }
    }
    
    func setupSplitInputView() {
        splitInputView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
}

