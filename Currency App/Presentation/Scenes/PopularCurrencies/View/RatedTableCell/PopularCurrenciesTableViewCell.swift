//
//  PopularCurrenciesTableViewCell.swift
//  Currency App
//
//  Created by Mohamed Khaled on 30/05/2023.
//

import UIKit

class PopularCurrenciesTableViewCell: UITableViewCell {

    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var ratedValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setUpCell(popularCurrencies: PopularCurrencies){
        currencySymbolLabel.text = popularCurrencies.currency
        ratedValueLabel.text = String(popularCurrencies.rate)
    }
}
