//
//  CustomTextField.swift
//  test_bcp
//
//  Created by iMac on 30/05/22.
//

import Foundation
import UIKit
enum TextType {
    case alphabetic
    case currency
    case url
    case text
}
protocol CustomTextFieldDelegate: class{
    func customTextFieldDelegate(text: String)
}
class CustomTextField: UITextField {
    /*
     0. alphabetic
     1. currency
     2. url
     3. text
     */

    var ALPHABETIC = "QWERTYUIOPASDFGHJKLZXCVBNMÑ qwertyuiopasdfghjklzxcvbnmñ"
    var NUMERIC = "1234567890"
    var charsValidate = ""
    var textType = TextType.text
    var customTextFieldDelegate: CustomTextFieldDelegate?
    @IBInspectable var textTypeIndex: Int = 3 {
        didSet{
            switchTextType()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setData()
    }
    
    func switchTextType(){
        switch textTypeIndex {
        case 0:
            textType = TextType.alphabetic
            charsValidate = ALPHABETIC
            break
        case 1:
            textType = TextType.currency
            charsValidate = NUMERIC
            break
        case 2:
            textType = TextType.url
        case 3:
            textType = TextType.text
            break
        default:
            break
        }
    }
    
    func setData(){
        self.delegate = self
        switch textType {
        case .currency:
            self.keyboardType = .numberPad
            break
        case .url:
            self.keyboardType = .URL
            break
        default:
            break
        }
        
        //addTitleInTextField()
    }
    
    func addTitleInTextField() {
        let labelTitle = UILabel(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y - 30, width: self.frame.width, height: 25))
        labelTitle.text = self.placeholder
        labelTitle.font = UIFont(name: labelTitle.font.familyName, size: 11)
        self.superview?.addSubview(labelTitle)
        //self.superview?.addSubview(labelTitle)
        //self.parentView?.addSubview(labelTitle)
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            var str = (textField.text ?? "")                        // "Hello, World"           
            
            customTextFieldDelegate?.customTextFieldDelegate(text: String(str.dropLast()))
        } else {
            customTextFieldDelegate?.customTextFieldDelegate(text: (textField.text ?? "") + string)
        }
        
        return charsValidate.isEmpty ? true : charsValidate.contains(string)
    }
}
