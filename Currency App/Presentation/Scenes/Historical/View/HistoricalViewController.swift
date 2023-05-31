//
//  HistoricalViewController.swift
//  Currency App
//
//  Created by Mohamed Khaled on 29/05/2023.
//

import UIKit
import RxSwift
import RxRelay

class HistoricalViewController: UIViewController {
    
    // MARK: - OutLets
    @IBOutlet weak var historicalTableView: UITableView!
    // MARK: - Variables
    private let viewModel = HistoricalViewModel()
    private let bag = DisposeBag()

    //MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNibFileTableView()
        tableViewSubscription()
        viewModel.viewDidLoad()

    }
    
    private func configureNibFileTableView() {
        historicalTableView.register(UINib(nibName: String(describing: HistoricalCell.self), bundle: nil),
        forCellReuseIdentifier: String(describing: HistoricalCell.self))
    }
    
    private func tableViewSubscription() {
        viewModel.historicalPublisher.bind(to: historicalTableView.rx.items(cellIdentifier: String(describing: HistoricalCell.self), cellType: HistoricalCell.self)) { (_ , element , cell ) in
            print(element)
            cell.setCellCurrency(currency: element)
        }.disposed(by: bag)
    }
    
}
