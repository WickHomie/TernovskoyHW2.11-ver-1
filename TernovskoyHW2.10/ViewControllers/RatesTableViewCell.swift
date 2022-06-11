//
//  RatesTableViewCell.swift
//  TernovskoyHW2.10
//
//  Created by Илья Терновской on 07.06.2022.
//

import UIKit

class RatesTableViewCell: UITableViewCell {

    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    
    func configure(with bitcoin: Bitcoin) {
        code.text = bitcoin.code
        rate.text = bitcoin.rate
        descriptions.text = bitcoin.description
    }

}
