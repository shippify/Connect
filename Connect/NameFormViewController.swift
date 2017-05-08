//
//  NameFormViewController.swift
//  Connect
//
//  Created by Kevin on 5/5/17.
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import Foundation
import UIKit
import Material

final class NameFormViewController: UIViewController {
  
  var monkeyId: String!
  
  @IBOutlet weak var nameTextField: ErrorTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  
  @IBAction func saveSession(_ sender: Any) {
    view.endEditing(true) 
    guard let name = nameTextField.text, !name.isEmpty else {
      nameTextField.isErrorRevealed = true
      return
    }
    
    DBManager.updateSession(name)
    UIApplication.shared.keyWindow?.rootViewController = AppNavigationDrawerController(rootViewController: rootViewController, leftViewController: leftViewController)
  }
  
  func setupViews(){
    nameTextField.placeholder = "Name"
    nameTextField.detail = "Name is a required field"
    nameTextField.isClearIconButtonEnabled = true
    nameTextField.delegate = self
    
    let leftViewEmail = UIImageView()
    leftViewEmail.image = UIImage(named: "usericon")
    nameTextField.leftView = leftViewEmail
  }
}
