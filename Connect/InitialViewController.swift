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
  @IBOutlet weak var nameTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  @IBAction func didPressRequestButton(_ sender: UIButton) {
    //Call API Criptext
    if (emailTextField.text?.isEmpty)! && (nameTextField.text?.isEmpty)! {
      let alertMissingParameters = UIAlertController(title: "Missing Parameters", message: "Please provide us an email and name for continue with Login", preferredStyle: .alert)
      
      let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertMissingParameters.addAction(defaultAction)
      
      present(alertMissingParameters, animated: true, completion: nil)
    } else {
      self.performSegue(withIdentifier: "toPasswordSegue", sender: self)
    }
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

}
