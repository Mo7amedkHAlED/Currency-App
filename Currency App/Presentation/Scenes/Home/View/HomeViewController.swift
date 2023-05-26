//
//  HomeViewController.swift
//  Currency App
//
//  Created by Mohamed Khaled on 26/05/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - OutLets
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var currencyNumberTextField: UITextField!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var changeFromToButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    
    // MARK: - Variables
    private let fromPickerView = UIPickerView()
    private let toPickerView = UIPickerView()
    
    //MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }


}
