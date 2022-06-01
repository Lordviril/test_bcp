//
//  QualifyAppViewController.swift
//  Yummy Rides
//
//  Created by pedro.daza on 10/11/21.
//  Copyright © 2021 Elluminati. All rights reserved.
//

import Foundation
import UIKit

class TextFieldFilter: UITextField {
    var listText = [String]()
    var textFieldFilterDelegate: TextFieldFilterDelegate?
    private var listItemsViewController: ListItemsViewController?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }
}
//MARK: -TextFieldFilter
extension TextFieldFilter: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let controler = self.findViewController(){
            self.text = ""
            listItemsViewController = ListItemsViewController.show(controller: controler, listText: listText, onSelectItem: { text, index, indexFilter in
                self.textFieldFilterDelegate?.onSelectItem(text: text, index: index, indexFilter: indexFilter)
                self.text = text
                self.resignFirstResponder()
            }, onDismiss: {
                self.resignFirstResponder()
            })
            listItemsViewController?.textContains = self.text ?? ""
            let globalPoint = self.superview?.convert(self.frame.origin, to: nil)
            listItemsViewController?.topTableViewLayaut.constant = ((globalPoint?.y ?? 100) + 0)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = ""
        if string == "" {
            var textLimit = "\(self.text ?? "")"
            textLimit.removeLast()
            text = "\(textLimit)"
        } else {
            text = "\(self.text ?? "")\(string)"
        }
        listItemsViewController?.textContains = text
        return true
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
//MARK: -TextFieldFilterDelegate
protocol TextFieldFilterDelegate{
    func onSelectItem(text: String, index: Int, indexFilter: Int)
}
