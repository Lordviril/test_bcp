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
    @IBOutlet weak var rateLabel: UILabel!
    
    var initMoneyInto: Money?
    var convertMoneyInto: Money?
    
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        // Do any additional setup after loading the view.
    }
    

    func initData(){
        guard let initMoney = initMoneyInto else {return}
        initMoneyLabel.text = initMoney.name
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func downTouchEvent(button: UIButton){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(completeEvent), userInfo: nil, repeats: false)
    }
    
    @IBAction func upTouchEvent(button: UIButton){
        
    }
    @IBAction func toExchange(button: UIButton) {
        
    }
}
