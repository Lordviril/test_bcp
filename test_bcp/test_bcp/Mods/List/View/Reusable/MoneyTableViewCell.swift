//
//  MoneyTableViewCell.swift
//  test_bcp
//
//  Created by iMac on 30/05/22.
//

import UIKit
import SDWebImage
class MoneyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var flagContryImageView: UIImageView!
    
    static let  identificador = "MoneyTableViewCell"
    static func nib() -> UINib  {   return UINib(nibName: "MoneyTableViewCell", bundle: nil)  }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(contryWithMoney: ContryWithMoney) {
        guard let contry = contryWithMoney.contry else {return}
        if let money = contryWithMoney.money{
            priceLabel.text = "Comprer USD = $\(money.buy_value) Vender USD = $\(money.sel_value)"
        }
        nameLabel.text = contry.name
        if let url = URL(string: contry.url_flag ?? "") {
            flagContryImageView.sd_setImage(with: url)
        }
    }
    
}
