//
//  LoginViewController.swift
//  Connect
//
//  Created by Gianni Carlo
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func didPressRequestButton(_ sender: UIButton) {
        //Call API Criptext
        
        self.performSegue(withIdentifier: "toPasswordSegue", sender: self)
    }
    
    
}
