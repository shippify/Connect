//
//  LoginViewController.swift
//  Connect
//
//  Created by Gianni Carlo
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import UIKit
import Material
import SwiftSpinner

class InitialViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: ErrorTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  @IBAction func didPressRequestButton(_ sender: UIButton) {
    //Call API Criptext
    view.endEditing(true)
    guard let email = emailTextField.text, !email.isEmpty else {
      emailTextField.isErrorRevealed = true
      return
    }
    
    let username = emailTextField.text!
    SwiftSpinner.show("Wait...")
    API.sign(username, completion: { (result) in
      SwiftSpinner.hide()
      switch(result) {
      case .success():
        self.performSegue(withIdentifier: "toPasswordSegue", sender: self)
      case .failure(_):
        self.emailTextField.detail = "You have to entry an valid email"
        self.emailTextField.isErrorRevealed = true
        break
      }
    }).resume()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toPasswordSegue" {
      let loginViewController = segue.destination as! LoginViewController
      loginViewController.username = emailTextField.text
    }
  }
  
}

extension InitialViewController {
  func setupViews() {
    emailTextField.placeholder = "Email"
    emailTextField.detail = "Email is a required field"
    emailTextField.isClearIconButtonEnabled = true
    emailTextField.delegate = self
    
    let leftViewEmail = UIImageView()
    leftViewEmail.image = #imageLiteral(resourceName: "name-icon")
    emailTextField.leftView = leftViewEmail

  }
}

extension UIViewController: TextFieldDelegate {
  public func textFieldDidEndEditing(_ textField: UITextField) {
    (textField as? ErrorTextField)?.isErrorRevealed = false
  }
  
  public func textFieldShouldClear(_ textField: UITextField) -> Bool {
    (textField as? ErrorTextField)?.isErrorRevealed = false
    return true
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    (textField as? ErrorTextField)?.isErrorRevealed = false
    return true
  }
}
