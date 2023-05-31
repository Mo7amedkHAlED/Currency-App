//
//  PopularCurrenciesViewController.swift
//  Currency App
//
//  Created by Mohamed Khaled on 30/05/2023.
//

import UIKit
import RxSwift
import RxCocoa

class PopularCurrenciesViewController: UIViewController {

    @IBOutlet weak var popularCurrenciesTableView: UITableView!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    
    var viewModel = PopularCurrenciesViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureNibFileTableView()
        tableViewSubscription()
        configureBaseCurrencyLabelText()
    }
    
    private func configureNibFileTableView() {
        popularCurrenciesTableView.register(UINib(nibName: String(describing: PopularCurrenciesTableViewCell.self), bundle: nil),
        forCellReuseIdentifier: String(describing: PopularCurrenciesTableViewCell.self))
    }

    private func tableViewSubscription() {
        viewModel.popularCurrenciesList.bind(to: popularCurrenciesTableView.rx.items(cellIdentifier: String(describing: PopularCurrenciesTableViewCell.self), cellType: PopularCurrenciesTableViewCell.self)) { (_ , element , cell ) in
            cell.setUpCell(popularCurrencies: element)
        }.disposed(by: bag)
    }
    
    private func configureBaseCurrencyLabelText() {
        baseCurrencyLabel.text = viewModel.baseCurrency
    }
}
