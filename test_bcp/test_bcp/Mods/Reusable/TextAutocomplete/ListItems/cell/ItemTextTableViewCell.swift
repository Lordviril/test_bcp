//
//  ItemTableViewCell.swift
//  Yummy Rides
//
//  Created by pedro.daza on 26/11/21.
//  Copyright © 2021 Elluminati. All rights reserved.
//

import UIKit

class ItemTextTableViewCell: UITableViewCell {
    @IBOutlet weak var txtItemText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setItem(text: String) {
        txtItemText.text = text
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
