//
//  CustomButton.swift
//  test_bcp
//
//  Created by iMac on 30/05/22.
//

import Foundation
import UIKit
// MARK: - @IBInspectable variables
@IBDesignable class CustomButton: UIButton {

    @IBInspectable var isEnabledAparence: Bool = false{
        didSet{
            self.isEnabled = isEnabledAparence
            if isEnabledAparence {
                self.backgroundColor = UIColor.blue
                self.titleLabel?.textColor = UIColor.white
                //self.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                self.backgroundColor = UIColor.gray
                self.titleLabel?.textColor = UIColor.black
                //
                self.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get { return self.layer.borderColor != nil ? UIColor(cgColor: self.layer.borderColor!) : nil }
        set { self.layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set { self.layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowColor: UIColor? {
        get { return self.layer.shadowColor != nil ? UIColor(cgColor: self.layer.shadowColor!) : nil }
        set { self.layer.shadowColor = newValue?.cgColor }
    }

    @IBInspectable var shadowOpacity: Float {
        get { return self.layer.shadowOpacity }
        set { self.layer.shadowOpacity = newValue }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get { return self.layer.shadowRadius }
        set { self.layer.shadowRadius = newValue }
    }
    
    @IBInspectable var disabledTitle: UIColor? {
        get { return self.titleColor(for: .disabled) }
        set { self.setTitleColor(newValue, for: .disabled) }
    }
    
    @IBInspectable var disabledBackground: UIColor?
    
    private var enabledBackgroundColor: UIColor?
}
