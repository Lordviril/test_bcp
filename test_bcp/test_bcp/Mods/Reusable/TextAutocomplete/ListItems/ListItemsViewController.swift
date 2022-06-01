//
//  QualifyAppViewController.swift
//  Yummy Rides
//
//  Created by pedro.daza on 10/11/21.
//  Copyright © 2021 Elluminati. All rights reserved.
//

import UIKit

class ListItemsViewController: UIViewController {

    @IBOutlet weak var btnDissmis: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topTableViewLayaut: NSLayoutConstraint!
    var listText = [String]()
    private var listTextFilter = [String]()
    var textContains: String = "" {
        didSet {
            filerText()
        }
    }
    
    var onSelectItem: ((String, Int, Int) -> Void)?
    var onDismiss: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    func setUp(){
        filerText()
        tableView.register(UINib(nibName: "ItemTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTextTableViewCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        btnDissmis.setTitle("", for: .normal)
    }
    
    private func filerText() {
        if textContains.isEmpty {
            listTextFilter = listText
        } else {
            listTextFilter = [String]()
            for text in listText {
                if text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).contains(textContains.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)) {
                    listTextFilter.append(text)
                }
            }
        }
        tableView.reloadData()
    }
    
    static func show(controller: UIViewController, listText: [String],  onSelectItem: @escaping ((String, Int, Int) -> Void), onDismiss: @escaping (() -> Void)) ->  ListItemsViewController{

        let listItemsViewController = ListItemsViewController(nibName: "ListItemsViewController", bundle: nil)
            listItemsViewController.listText = listText
            listItemsViewController.onSelectItem = onSelectItem
            listItemsViewController.onDismiss = onDismiss
            listItemsViewController.modalPresentationStyle = .overFullScreen
            controller.present(listItemsViewController, animated: true, completion: nil)
            return listItemsViewController
    }
    
    //MARK: -Actions
    @IBAction func dissmisPressed(button: UIButton) {
        onDismiss?()
        self.dismiss(animated: true)
    }

}
//MARK: -UITableViewDataSource
extension ListItemsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTextFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let itemTableCell = tableView.dequeueReusableCell(withIdentifier: "ItemTextTableViewCell", for: indexPath) as? ItemTextTableViewCell {
            itemTableCell.setItem(text: listTextFilter[indexPath.row])
            return itemTableCell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
//MARK: -ListItemsViewController
extension ListItemsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = listText.firstIndex(of: listTextFilter[indexPath.row]) ?? 0
        onSelectItem?(listTextFilter[indexPath.row], index, indexPath.row)
        self.dismiss(animated: true)
    }
}
