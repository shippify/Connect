//
//  LoginViewController.swift
//  Connect
//
//  Created by Gianni Carlo
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import UIKit
import SwiftSpinner

class LoginViewController: UIViewController {
  var username: String!

  @IBOutlet weak var firstTextField: UITextField!
  @IBOutlet weak var secondTextField: UITextField!
  @IBOutlet weak var thridTextField: UITextField!
  @IBOutlet weak var fourTextField: UITextField!
  @IBOutlet weak var emailLabel: UILabel!
  
  lazy var rootViewController : RotationNavigationController = {
    return UIStoryboard.viewController(identifier: "Main") as! RotationNavigationController
  }()
  
  lazy var leftViewController: SlideMenuViewController = {
    return UIStoryboard.viewController(identifier: "Menu") as! SlideMenuViewController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailLabel.text = "Please check your inbox, we send you a code to your account:\(username!)"
    
    firstTextField.delegate = self
    secondTextField.delegate = self
    thridTextField.delegate = self
    fourTextField.delegate = self
    
    firstTextField.becomeFirstResponder()
    
    firstTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    secondTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    thridTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    fourTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

  }
  
  func textFieldDidChange(_ textField: UITextField) {
    if(self.firstTextField.text?.characters.count == 1 && self.secondTextField.text?.characters.count == 1 && thridTextField.text?.characters.count == 1 && self.fourTextField.text?.characters.count == 1) {
      let a = firstTextField.text!
      let b = secondTextField.text!
      let c = thridTextField.text!
      let d = fourTextField.text!
      let code = [a,b,c,d].joined()
      view.endEditing(true)
      SwiftSpinner.show("wait...")
      API.auth(username, code: code, completion: { [weak self] (result) in
        switch(result) {
        case .success(let monkeyId):
          SwiftSpinner.hide()
          guard let strongSelf = self else {
            return
          }
          
          DBManager.createSession(monkeyId, name: "", email: (strongSelf.username)!)
          strongSelf.successAnimation()
        case .failure(_):
          SwiftSpinner.hide()
          self?.wrongCodeAnimation()
        }
      }).resume()
      
    }
    
    if textField.text?.characters.count == 0 {
      if (textField == self.fourTextField) {
        textField.resignFirstResponder()
        thridTextField.becomeFirstResponder()
      }
      else if (textField == self.thridTextField) {
        textField.resignFirstResponder()
        secondTextField.becomeFirstResponder()
      }
      else if (textField == self.secondTextField) {
        textField.resignFirstResponder()
        firstTextField.becomeFirstResponder()
      }
    }
  }
  
  override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let  char = string.cString(using: String.Encoding.utf8)!
    let isBackSpace = strcmp(char, "\\b")
    
    if (isBackSpace != -92) {
      if textField.text?.characters.count == 1 {
        if (textField == self.firstTextField) {
          textField.resignFirstResponder()
          secondTextField.becomeFirstResponder()
        }
        else if (textField == self.secondTextField) {
          textField.resignFirstResponder()
          thridTextField.becomeFirstResponder()
        }
        else if (textField == self.thridTextField) {
          textField.resignFirstResponder()
          fourTextField.becomeFirstResponder()
        }
      }
    }
    return true
  }

  
  func wrongCodeAnimation() {
    
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 4
    animation.autoreverses = true
    animation.addWrongAnimation(textFields: firstTextField, secondTextField, thridTextField, fourTextField)
    
  }
  
  func successAnimation() {
    UIApplication.shared.keyWindow?.rootViewController = AppNavigationDrawerController(rootViewController: rootViewController, leftViewController: leftViewController)
  }
}

extension CABasicAnimation {
  
  func addWrongAnimation(textFields: UITextField...){
    for textField in textFields {
      self.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
      self.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
      textField.layer.add(self, forKey: "position")
    }
  }
}
