//
//  HomeViewController.swift
//  Currency App
//
//  Created by Mohamed Khaled on 26/05/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    // MARK: - OutLets
    @IBOutlet weak var currencyNumberTextField: UITextField!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    @IBOutlet weak var changeFromToButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultButton: UIButton!
    // MARK: - Variables
    private let fromPickerView = UIPickerView()
    private let toPickerView = UIPickerView()
    private let bag = DisposeBag()
    private var viewModel: HomeViewModel
    
    // MARK: - Init
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToResult()
        setNavigationController()
        bindingToViewModel()
        pickerCurrencySymbols()
        configureFromPickerViewSubscriber()
        configureToPickerViewSubscriber()
        resultButtonSubscribation()
        bindingFromViewModel()
        viewModel.viewDidLoad()
        createTapGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationController()
    }
    
    private func createTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(dismissPicker))
        view.addGestureRecognizer(tapGesture)
    }
    // to dismiss picker view & keyboard
    @objc private func dismissPicker(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setNavigationController(){
        navigationController?.navigationBar.isHidden = true
        resultView.isHidden = true
    }
    
    private func pickerCurrencySymbols(){
        fromCurrencyTextField.inputView = fromPickerView
        toCurrencyTextField.inputView = toPickerView
    }
    
    private func bindingToViewModel() {
        currencyNumberTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.amountBehavior)
            .disposed(by: bag)
        
        fromCurrencyTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.fromCurrencyBehavior)
            .disposed(by: bag)
        
        toCurrencyTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.toCurrencyBehavior)
            .disposed(by: bag)
        
        changeFromToButton
            .rx
            .tap
            .bind(to: viewModel.swipCurrencyChange)
            .disposed(by: bag)
    }
    
    private func bindingFromViewModel() {
        viewModel.combineFromToFields().subscribe(onNext: {[weak self] (fromTxt , toTxt) in
            guard let self = self else {return}
            self.fromCurrencyTextField.text = fromTxt
            self.toCurrencyTextField.text = toTxt
        }).disposed(by: bag)
    }
    
    private func subscribeToResult() {
        viewModel.resultCurrenyPublisher.asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] currency in
                guard let self = self else { return }
                self.resultLabel.text = String(currency)
                self.resultView.isHidden = false
                print("Result is \(currency)")
            }).disposed(by: bag)
    }
    
    private func configureFromPickerViewSubscriber() {
        viewModel
            .currencyBehavior.asObservable()
            .bind(to: fromPickerView.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: bag)

        fromPickerView.rx.modelSelected(String.self)
            .map({$0[0]}).subscribe(onNext: { [weak self] selected in
                guard let self = self else {return }
                self.viewModel.fromCurrencyBehavior.accept(selected)
        }).disposed(by: bag)
    }
    
    private func configureToPickerViewSubscriber() {
        viewModel
            .currencyBehavior.asObservable()
            .bind(to: toPickerView.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: bag)

        toPickerView.rx.modelSelected(String.self)
            .map({$0[0]}).subscribe(onNext: { [weak self] selected in
                guard let self = self else {return}
                self.viewModel.toCurrencyBehavior.accept(selected)
        }).disposed(by: bag)
    }
    
    private func resultButtonSubscribation() {
        resultButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else  { return }
            self.viewModel.fetchResult()
        }).disposed(by: bag)
    }
    //method to show alert
    private func showAlert(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment:"Error"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default))
        present(alert, animated: true)
    }
}
