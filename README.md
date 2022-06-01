# Test BCP

La aplicación es una muestra de las fotos publicadas dia tras dia de la nasa.

## Installation

Use cocoa pods [cocoapods](https://cocoapods.org/) he instala los pods de dependencias .

```bash
pod install
```

## Dependencias Usadas

```javascript
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'test_bcp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SDWebImage', '~> 5.0'
  # Pods for test_bcp

  target 'test_bcpTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'test_bcpUITests' do
    # Pods for testing
  end

end

```

- lottie-ios: consumo he implementación de animaciones .json.
- SDWebImage: descargar imagenes y menejo de cache para su reconsumo posteriormente.

## Arquitectura usada
- mvvm: la idea es la implementación de [POP](https://medium.com/globallogic-latinoamerica-mobile/la-programaci%C3%B3n-orientada-a-protocolos-en-swift-3548ed2dc2f1) conjunto con un viewModel con los protocolos
```swift
import Foundation
import UIKit

protocol ListContryViewModelDelegate {
    func onSuccesGetContry(listContry: [ContryWithMoney])
}
```
- y por medio de binding entregar los resuelto en los servicios para las vistas

```swift
//MARK: -ListContryViewModelDelegate
extension ViewController: ListContryViewModelDelegate {
    func onSuccesGetContry(listContry: [ContryWithMoney]) {
        self.listContry = listContry
    }
    
}
```
- y por medio del viewModel nos comunicamos con las vista.

```swift
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

```

- obtener la lista de paises con su respectiva moneda

## Depliegue continuo(CD)
- se contemplo utilizar [fastlane](https://fastlane.tools/) pero al final nos fuimos por [bitrise](https://app.bitrise.io/) por que por medio de cajones por debamos nos construye nuestro documento [fastlane](https://fastlane.tools/)

- empezamos con la configuracion del proyecto seleccion del repo y la rama

![firebasestorage](https://firebasestorage.googleapis.com/v0/b/testyummy-26178.appspot.com/o/Captura%20de%20Pantalla%202021-10-26%20a%20la(s)%2012.20.37%20a.%C2%A0m..png?alt=media&token=162e5d7a-01f1-4b8b-9365-e4d773ec2cf8)

![firebasestorage](https://firebasestorage.googleapis.com/v0/b/testyummy-26178.appspot.com/o/Captura%20de%20Pantalla%202021-10-26%20a%20la(s)%2012.21.26%20a.%C2%A0m..png?alt=media&token=b32dbbed-f91e-49fa-ace2-a8f31a9b0896)

- al terminar la configuración encontraremos un dashboard con el resumen de nuestra configuración

![firebasestorage](https://firebasestorage.googleapis.com/v0/b/testyummy-26178.appspot.com/o/Captura%20de%20Pantalla%202021-10-26%20a%20la(s)%2012.22.40%20a.%C2%A0m..png?alt=media&token=b2fe0b65-072f-4c74-b1bd-b123d2e70496)

- posteriormente podemos empezar a gregar cajones que por debajo configuran nuestra fastlane o incluso otras herramientas

- en este caso agregaremos una de [firebase distribution](https://firebase.google.com/?gclid=CjwKCAjwq9mLBhB2EiwAuYdMtU3Cg_kLyrNm1v0lD4kAFiKr2atanP8hXV7_ifKCnyOyJ_uNDFPenBoC8NAQAvD_BwE&gclsrc=aw.ds)

![firebasestorage](https://firebasestorage.googleapis.com/v0/b/testyummy-26178.appspot.com/o/Captura%20de%20Pantalla%202021-10-26%20a%20la(s)%2012.27.45%20a.%C2%A0m..png?alt=media&token=8705c329-f616-484a-a26a-4bb627b0aa65)

- configuramos nuestra consola de firebase
- agregamos los correos a los que queremos liberar la version qa en develop segun ambiente

![firebasestorage](https://firebasestorage.googleapis.com/v0/b/juegosdemesa-9a7d0.appspot.com/o/Captura%20de%20Pantalla%202022-06-01%20a%20la(s)%207.58.41%20a.m..png?alt=media&token=0c41713b-db8e-45f0-929b-6209411b3331)

- y cada vez que hagamos un pull request a nuestra rama qa tendremos automáticamente un build con las características de workflow ya construidas


## Video demostrativo

[![IMAGE ALT TEXT HERE](https://firebasestorage.googleapis.com/v0/b/juegosdemesa-9a7d0.appspot.com/o/Simulator%20Screen%20Shot%20-%20iPhone%2011%20Pro%20-%202022-06-01%20at%2008.05.35.png?alt=media&token=c79e412f-291b-4b25-a34c-53fd9b5430a2)](https://firebasestorage.googleapis.com/v0/b/juegosdemesa-9a7d0.appspot.com/o/Simulator%20Screen%20Recording%20-%20iPhone%2011%20Pro%20-%202022-06-01%20at%2008.04.15.mp4?alt=media&token=a46405c3-d733-4e2a-ab63-9f50e9991cce)
