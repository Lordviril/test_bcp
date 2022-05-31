//
//  ValidateFormView.swift
//  test_bcp
//
//  Created by iMac on 30/05/22.
//

import Foundation
import UIKit

class ValidateFormView: CustomView {
    
    var buttonValidate: CustomButton?
    let timer: Timer?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    func addButton(button: CustomButton) {
        self.buttonValidate = button
    }
    
    @objc func fireTimer() {
        
        for view in self.subviews {
            
        }
    }
    
}
