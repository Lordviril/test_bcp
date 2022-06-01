//
//  ContryViewModel.swift
//  test_bcp
//
//  Created by Pedro Alonso Daza B on 31/05/22.
//

import Foundation
import UIKit
import CoreData

protocol ContryViewModelDelegate: class{
    func onComplete(listMoney:[Money])
    func onCompleteSaveContry(contry: Contry)
}

class ContryViewModel {
    var contryViewModelDelegate: ContryViewModelDelegate?
    var parent: ContryViewController?
    
    init(parent: ContryViewController, contryViewModelDelegate: ContryViewModelDelegate) {
        self.parent = parent
        self.contryViewModelDelegate = contryViewModelDelegate
    }
    
    func listGetMoney() {
        
        var listMoney: [Money] = []
        
        //2
         let fetchRequest =
           NSFetchRequest<Money>(entityName: "Money")
        
        do{
            if let context = CoreDataUtil.shared.managedContext {
                listMoney = try context.fetch(fetchRequest)
                self.contryViewModelDelegate?.onComplete(listMoney: listMoney)
            }
        } catch {
            
        }
        
    }
    
    func addContry(name: String, urlImage: String, moneyId: Int) {
        guard let context = CoreDataUtil.shared.managedContext else {return}
        var listContry: [Contry] = []
        
        //2
         let fetchRequestContry =
           NSFetchRequest<Contry>(entityName: "Contry")
        
        do {
            if let context = CoreDataUtil.shared.managedContext {
                listContry = try context.fetch(fetchRequestContry)
            
                let contry1 = Contry(context: context)
                contry1.name = name
                contry1.id = (Int64(listContry.count + 1))
                contry1.money = Int64(moneyId)
                contry1.url_flag = urlImage
                
                do {
                    try context.save()
                    self.contryViewModelDelegate?.onCompleteSaveContry(contry: contry1)
                }
                catch {
                    // Handle Error
                }
            }
            
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
}
