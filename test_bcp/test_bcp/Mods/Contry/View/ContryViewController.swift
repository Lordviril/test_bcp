//
//  ContryViewController.swift
//  test_bcp
//
//  Created by iMac on 30/05/22.
//

import UIKit

class ContryViewController: UIViewController {

    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var urlFlagTextField: CustomTextField!
    @IBOutlet weak var addutton: CustomButton!
    @IBOutlet weak var validationView: ValidateFormView!
    @IBOutlet weak var moneyTextFieldFilter: TextFieldFilter!
    
    var contryViewModel: ContryViewModel?
    var complete: ((Contry) -> Void)?
    var listMoneyText = [String]()
    var moneyId = 0
    var listMoney = [Money]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        // Do any additional setup after loading the view.
    }


    func setData(){
        contryViewModel = ContryViewModel(parent: self, contryViewModelDelegate: self)
        contryViewModel?.listGetMoney()
        moneyTextFieldFilter.textFieldFilterDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validationView.addButton(button: addutton)
        nameTextField.addTitleInTextField()
        urlFlagTextField.addTitleInTextField()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClose(button: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onSave(button: UIButton) {
        contryViewModel?.addContry(name: nameTextField.text ?? "", urlImage: urlFlagTextField.text ?? "", moneyId: moneyId)
    }
    
    static func show(controller: UIViewController, complete: @escaping ((Contry) -> Void)) {
        let contryViewController = ContryViewController(nibName: "ContryViewController", bundle: Bundle.main)
        contryViewController.complete = complete
        contryViewController.modalPresentationStyle = .popover
        
        contryViewController.modalPresentationStyle = .overFullScreen
        controller.present(contryViewController, animated: true)
    }

}

extension ContryViewController: ContryViewModelDelegate{
    func onCompleteSaveContry(contry: Contry) {
        
        self.dismiss(animated: true) {
            self.complete?(contry)
        }
    }
    
    func onComplete(listMoney: [Money]) {
        self.listMoney = listMoney
        moneyTextFieldFilter.listText = listMoney.map({ $0.name ?? "" })
    }
    
    
}

extension ContryViewController: TextFieldFilterDelegate {
    func onSelectItem(text: String, index: Int, indexFilter: Int) {
        moneyId = Int(self.listMoney[index].id)
    }
    
    
}
