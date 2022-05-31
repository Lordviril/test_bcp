//
//  AppDelegate.swift
//  test_bcp
//
//  Created by iMac on 29/05/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create a new UserEntity in the
        // NSManagedObjectContext context
        

        // Assign values to the entity's properties
        
        if let appDelegate =
            UIApplication.shared.delegate as? AppDelegate{
            
            // 1
            let managedContext =
              appDelegate.persistentContainer.viewContext
            
            CoreDataUtil.shared.managedContext = managedContext
          
        }
          
        if let isDataInitial = UserDefaults.standard.bool(forKey: "KISaveDataInitial") as? Bool  {
            if !isDataInitial {
                guard let context = CoreDataUtil.shared.managedContext else {return true}
                let money1 = Money(context: context)
                money1.id = 1
                money1.name = "Pesos"
                money1.buy_value = 0.00024
                money1.sel_value = 0.00026
                
                let money2 = Money(context: context)
                money2.id = 2
                money2.name = "Sol"
                money2.buy_value = 0.25
                money2.sel_value = 0.27
                
                let money3 = Money(context: context)
                money3.id = 3
                money3.name = "Dolar"
                money3.buy_value = 1
                money3.sel_value = 1.01
                
                let money4 = Money(context: context)
                money4.id = 4
                money4.name = "Euro"
                money4.buy_value = 1.07
                money4.sel_value = 1.08

                let contry1 = Contry(context: context)
                contry1.name = "Colomia"
                contry1.id = 1
                contry1.money = 1
                contry1.url_flag = "https://cdn.pixabay.com/photo/2012/04/15/21/27/colombia-35364__480.png"
                
                let contry2 = Contry(context: context)
                contry2.name = "Peru"
                contry2.id = 2
                contry2.money = 2
                contry2.url_flag = "https://upload.wikimedia.org/wikipedia/commons/5/5f/Bandera_de_peru.png"
                
                let contry3 = Contry(context: context)
                contry3.name = "Estados Unidos"
                contry3.id = 3
                contry3.money = 3
                contry3.url_flag = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/1024px-Flag_of_the_United_States.svg.png"
                
                let contry4 = Contry(context: context)
                contry4.name = "España"
                contry4.id = 4
                contry4.money = 4
                contry4.url_flag = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Bandera_de_Espa%C3%B1a_1978.png/1024px-Bandera_de_Espa%C3%B1a_1978.png"
                
                let contry5 = Contry(context: context)
                contry5.name = "Ecuador"
                contry5.id = 5
                contry5.money = 3
                contry5.url_flag = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Flag_of_Ecuador.svg/1024px-Flag_of_Ecuador.svg.png"
                
                let contry6 = Contry(context: context)
                contry6.name = "Francia"
                contry6.id = 6
                contry6.money = 4
                contry6.url_flag = "https://upload.wikimedia.org/wikipedia/commons/c/c3/Flag_of_France.svg"
                
                do {
                    try context.save()
                    UserDefaults.standard.set(true, forKey: "KISaveDataInitial")
                }
                catch {
                    // Handle Error
                }
                
            }
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "test_bcp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

