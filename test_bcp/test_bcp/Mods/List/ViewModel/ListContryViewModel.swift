//
//  ListContryViewModel.swift
//  test_bcp
//
//  Created by Pedro Alonso Daza B on 31/05/22.
//

import Foundation
import CoreData

protocol ListContryViewModelDelegate {
    func onSuccesGetContry(listContry: [ContryWithMoney])
}
class ListContryViewModel {
    var listContryViewModelDelegate: ListContryViewModelDelegate?
    var parent: ViewController?
    init(parent: ViewController, listContryViewModelDelegate: ListContryViewModelDelegate) {
        self.parent = parent
        self.listContryViewModelDelegate = listContryViewModelDelegate
    }
    
    func getListContry() {
        var listContry: [Contry] = []
        
        //2
         let fetchRequest =
           NSFetchRequest<Contry>(entityName: "Contry")
         
         //3
         do {
             if let context = CoreDataUtil.shared.managedContext {
                 listContry = try context.fetch(fetchRequest)
                 let listContryWithMoney = listContry.map { contry -> ContryWithMoney in
                     let contryWithMoney = ContryWithMoney()
                     contryWithMoney.contry = contry
                     let fetchRequestMoney =
                       NSFetchRequest<Money>(entityName: "Money")
                     fetchRequestMoney.predicate = NSPredicate(
                        format: "id == %d", contry.money
                     )
                     do{
                         let money: Money? = try context.fetch(fetchRequestMoney).first
                         contryWithMoney.money = money
                     }catch {
                         
                     }
                     
                     
                     return contryWithMoney
                 }
                 
                 self.listContryViewModelDelegate?.onSuccesGetContry(listContry: listContryWithMoney)
             }
             
         } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
         }
    }
    
}
