//
//  CurrencyTransferenceViewController.swift
//  test_bcp
//
//  Created by Pedro Alonso Daza B on 31/05/22.
//

import UIKit

class CurrencyTransferenceViewController: UIViewController {
    
    

    @IBOutlet weak var initMoneyCustomTextField: CustomTextField!
    @IBOutlet weak var convertMoneyCustomTextField: CustomTextField!
    @IBOutlet weak var initMoneyLabel: UILabel!
    @IBOutlet weak var convertMoneyLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var initOperationButton: CustomButton!
    @IBOutlet weak var messaggeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var convertValidateFormView: ValidateFormView!
    
    var initMoneyInto: Money?
    var convertMoneyInto: Money?
    var currencyTransferViewModel: CurrencyTransferViewModel?
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initMoneyCustomTextField.addTitleInTextField()
        convertMoneyCustomTextField.addTitleInTextField()
    }
    func initData(){
        guard let initMoney = initMoneyInto else {return}
        initMoneyLabel.text = initMoney.name
        convertValidateFormView.addButton(button: initOperationButton)
        currencyTransferViewModel = CurrencyTransferViewModel(parent: self, currencyTransferViewModelDelegate: self)
        initMoneyCustomTextField.customTextFieldDelegate = self
        
        messaggeLabel.isHidden = false
    }

    @IBAction func downTouchEvent(button: UIButton){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(completeEvent), userInfo: nil, repeats: false)
    }
    
    @IBAction func upTouchEvent(button: UIButton){
        timer?.invalidate()
    }
    
    @objc func completeEvent() {
        ViewController.show(controller: self) { money in
            self.convertMoneyInto = money
            guard let convertMoney = self.convertMoneyInto else {return}
            self.convertMoneyLabel.text = convertMoney.name
            if !(self.initMoneyCustomTextField.text ?? "").isEmpty {
                guard let initMoney = self.initMoneyInto else {return}
                self.currencyTransferViewModel?.convert(enterValue: Double(self.initMoneyCustomTextField.text ?? "") ?? 0, initMoney: initMoney, convertMoney: convertMoney)
            }
        }
    }
    
    @IBAction func toExchange(button: UIButton) {
        let tempInitMoneyInto = initMoneyInto
        let tempConvertMoneyInto = convertMoneyInto
        
        initMoneyInto = tempConvertMoneyInto
        convertMoneyInto = tempInitMoneyInto
        
        guard let initMoney = initMoneyInto else {return}
        guard let convertMoney = self.convertMoneyInto else {return}
        
        initMoneyLabel.text = initMoney.name
        self.convertMoneyLabel.text = convertMoney.name
        
        if !(self.initMoneyCustomTextField.text ?? "").isEmpty {
            guard let initMoney = self.initMoneyInto else {return}
            self.currencyTransferViewModel?.convert(enterValue: Double(self.initMoneyCustomTextField.text ?? "") ?? 0, initMoney: initMoney, convertMoney: convertMoney)
        }
    }
}
//MARK: -CurrencyTransferViewModelDelegate
extension CurrencyTransferenceViewController: CurrencyTransferViewModelDelegate {
    func onCompleteConvert(buyValue: Double, selValue: Double, totalValue: Double) {
        convertMoneyCustomTextField.text = "$\(totalValue)"
        rateLabel.text = "Comprar USD = $\(buyValue) Vender USD = $\(selValue)"
    }
}
//MARK: -CustomTextFieldDelegate
extension CurrencyTransferenceViewController: CustomTextFieldDelegate {
    func customTextFieldDelegate(text: String) {
        if text.isEmpty {
            convertMoneyCustomTextField.text = ""
            return
        }
        guard let initMoney = initMoneyInto else {return}
        guard let convertMoney = self.convertMoneyInto else {return}
        if let value = Double(text) {
            messaggeLabel.isHidden = true
            currencyTransferViewModel?.convert(enterValue: value, initMoney: initMoney, convertMoney: convertMoney)
        }
    }
}
