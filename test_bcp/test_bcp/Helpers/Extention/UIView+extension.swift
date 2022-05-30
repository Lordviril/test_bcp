//
//  UIView+extension.swift
//  test_bcp
//
//  Created by iMac on 30/05/22.
//

import Foundation
import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    var parentView: UIView? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let view = parentResponder as? UIView {
                return view
            }
        }
        return nil
    }
}
