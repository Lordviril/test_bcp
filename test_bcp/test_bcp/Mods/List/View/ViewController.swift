//
//  ViewController.swift
//  test_bcp
//
//  Created by iMac on 29/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contryTableView: UITableView!
    
    var listContryViewModel: ListContryViewModel?
    var listContry = [ContryWithMoney]()
    var selectMoney: ((Money) -> Void)?
    var isPopOver = false
    var sendMoney = Money()
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitComponent()
        // Do any additional setup after loading the view.
    }

    func setInitComponent() {
        contryTableView.register(MoneyTableViewCell.nib(), forCellReuseIdentifier: MoneyTableViewCell.identificador)
        contryTableView.delegate = self
        contryTableView.dataSource = self
        listContryViewModel = ListContryViewModel(parent: self, listContryViewModelDelegate: self)
        listContryViewModel?.getListContry()
    }

    @IBAction func onAddContry(_ sender: UIBarButtonItem) {
        ContryViewController.show(controller: self) { contry in
            self.listContryViewModel?.getListContry()
            self.contryTableView.reloadData()
        }
    }
    
    static func show(controller: UIViewController, selectMoney: @escaping ((Money) -> Void)) {
        let storyBoard1 = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyBoard1.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            viewController.selectMoney = selectMoney
            viewController.isPopOver = true
            viewController.modalPresentationStyle = .popover
            
            controller.present(viewController, animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currencyTransferenceViewController = segue.destination as? CurrencyTransferenceViewController {
            currencyTransferenceViewController.initMoneyInto = sendMoney
        }
    }
}
//MARK: -UITableViewDelegate
extension ViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPopOver {
            self.dismiss(animated: true) {
                if let money = self.listContry[indexPath.row].money{
                    self.selectMoney?(money)
                }
            }
        } else {
            if let money = self.listContry[indexPath.row].money{
                self.sendMoney = money
                performSegue(withIdentifier: "showConvertMoney", sender: nil)
            }
        }
    }
    
}
//MARK: -UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listContry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MoneyTableViewCell.identificador, for: indexPath) as?  MoneyTableViewCell {
            cell.setData(contryWithMoney: listContry[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}
//MARK: -ListContryViewModelDelegate
extension ViewController: ListContryViewModelDelegate {
    func onSuccesGetContry(listContry: [ContryWithMoney]) {
        self.listContry = listContry
    }
    
}

