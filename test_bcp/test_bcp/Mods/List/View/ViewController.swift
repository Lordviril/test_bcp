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
    
}
//MARK: -UITableViewDelegate
extension ViewController: UITableViewDelegate {
   
    
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

