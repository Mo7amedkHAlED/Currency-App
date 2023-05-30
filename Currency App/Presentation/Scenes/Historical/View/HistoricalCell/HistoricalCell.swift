//
//  HistoricalCell.swift
//  Currency App
//
//  Created by Mohamed Khaled on 29/05/2023.
//

import UIKit

class HistoricalCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var resultLBL: UILabel!
    @IBOutlet weak var fromLBl: UILabel!
    @IBOutlet weak var amountLBL: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellCurrency(currency: HistoricalModel){
        dateLbl.text = currency.date
        toLbl.text = currency.toCurrency
        fromLBl.text = currency.fromCurrency
        resultLBL.text = String(currency.result)
        amountLBL.text = String(currency.amount)
    }
    
}
