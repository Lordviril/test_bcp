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
    
    func convert(enterValue: Double, initMoney: Money, convertMoney: Money) {
        let usdBuyValue = enterValue * initMoney.buy_value
        let convertmoneyBuyVslue = usdBuyValue / convertMoney.buy_value
        
        let usdSelValue = enterValue * initMoney.sel_value
        let convertmoneySelVslue = usdSelValue / convertMoney.sel_value
        
        self.currencyTransferViewModelDelegate?.onCompleteConvert(buyValue: convertmoneyBuyVslue, selValue: convertmoneySelVslue, totalValue: convertmoneySelVslue)
    }
}
