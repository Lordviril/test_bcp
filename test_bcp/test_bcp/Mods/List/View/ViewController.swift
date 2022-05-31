//
//  ViewController.swift
//  test_bcp
//
//  Created by iMac on 29/05/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //performSegue(withIdentifier: "showSecondController", sender: nil)
        ContryViewController.show(controller: self) { contry in

        }
    }


}

