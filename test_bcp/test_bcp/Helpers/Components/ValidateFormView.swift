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
    var timer: Timer?
    var isValidate: Bool = false
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setInit()
    }
    func setInit() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    //
//    required init?(coder: NSCoder) {
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
//    }
    func addButton(button: CustomButton) {
        self.buttonValidate = button
    }
    
    @objc func fireTimer() {
        var validate = true
        for view in self.subviews {
            if let textField = view as? CustomTextField {
                if (textField.text ?? "").isEmpty {
                    validate = false
                    break;
                }
            }
        }
        self.isValidate = validate
        self.buttonValidate?.isEnabledAparence = self.isValidate
    }
    
    
    
}
