//
//  CurrencyTransferViewModel.swift
//  test_bcp
//
//  Created by Pedro Alonso Daza B on 1/06/22.
//

import Foundation
import UIKit

protocol CurrencyTransferViewModelDelegate: class {
    func onCompleteConvert(buyValue: Double, selValue: Double, totalValue: Double)
}

class CurrencyTransferViewModel {
    var currencyTransferViewModelDelegate: CurrencyTransferViewModelDelegate?
    var parent: CurrencyTransferenceViewController?
    init(parent: CurrencyTransferenceViewController, currencyTransferViewModelDelegate: CurrencyTransferViewModelDelegate) {
        self.parent = parent
        self.currencyTransferViewModelDelegate = currencyTransferViewModelDelegate
    }
    
    func convert()
}
