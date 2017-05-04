//
//  LoginViewController.swift
//  Connect
//
//  Created by Gianni Carlo
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import UIKit
import Material

class InitialViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: ErrorTextField!
  @IBOutlet weak var nameTextField: ErrorTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  @IBAction func didPressRequestButton(_ sender: UIButton) {
    //Call API Criptext
    
    guard let name = nameTextField.text, !name.isEmpty else {
      nameTextField.isErrorRevealed = true
      return
    }
    
    guard let email = emailTextField.text, !email.isEmpty else {
      emailTextField.isErrorRevealed = true
      return
    }
    
    self.performSegue(withIdentifier: "toPasswordSegue", sender: self)
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

extension InitialViewController {
  func setupViews() {
    emailTextField.placeholder = "Email"
    emailTextField.detail = "Email is a required field"
    emailTextField.isClearIconButtonEnabled = true
    emailTextField.delegate = self
    
    nameTextField.placeholder = "Name"
    nameTextField.detail = "Name is a required field"
    nameTextField.isClearIconButtonEnabled = true
    nameTextField.delegate = self
    
    let leftViewEmail = UIImageView()
    leftViewEmail.image = #imageLiteral(resourceName: "envelop-icon")
    emailTextField.leftView = leftViewEmail

    let leftViewName = UIImageView()
    leftViewName.image = #imageLiteral(resourceName: "name-icon")
    nameTextField.leftView = leftViewName

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
