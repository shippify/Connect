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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case "toPasswordSegue":
      let loginViewController = segue.destination as! LoginViewController
      loginViewController.email = emailTextField.text
    default:
      fatalError()
    }
  }
    
    @IBAction func didPressRequestButton(_ sender: UIButton) {
        //Call API Criptext
        self.performSegue(withIdentifier: "toPasswordSegue", sender: self)
    }
    
    
}
