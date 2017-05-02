//
//  LoginViewController.swift
//  Connect
//
//  Created by Gianni Carlo
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
  
  var email: String!
  @IBOutlet weak var firstTextField: UITextField!
  @IBOutlet weak var secondTextField: UITextField!
  @IBOutlet weak var thridTextField: UITextField!
  @IBOutlet weak var fourTextField: UITextField!
  @IBOutlet weak var emailLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emailLabel.text = "Please check your inbox, we send you a code to your account:\(email!)"
    
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
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
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
    
    
    animation.fromValue = NSValue(cgPoint: CGPoint(x: firstTextField.center.x - 10, y: firstTextField.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: firstTextField.center.x + 10, y: firstTextField.center.y))
    firstTextField.layer.add(animation, forKey: "position")
    
    animation.fromValue = NSValue(cgPoint: CGPoint(x: secondTextField.center.x - 10, y: secondTextField.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: secondTextField.center.x + 10, y: secondTextField.center.y))
    secondTextField.layer.add(animation, forKey: "position")
    
    animation.fromValue = NSValue(cgPoint: CGPoint(x: thridTextField.center.x - 10, y: thridTextField.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: thridTextField.center.x + 10, y: thridTextField.center.y))
    thridTextField.layer.add(animation, forKey: "position")
    
    animation.fromValue = NSValue(cgPoint: CGPoint(x: fourTextField.center.x - 10, y: fourTextField.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: fourTextField.center.x + 10, y: fourTextField.center.y))
    fourTextField.layer.add(animation, forKey: "position")
  }
  
  func successAnimation() {
    let monkeyId: String = ""
    let name: String = ""
    DBManager.createSession(monkeyId, name: name, email: email)
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let rotationNavigationController = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! UINavigationController
    UIApplication.shared.keyWindow?.rootViewController = rotationNavigationController
  }
  
  @IBAction func didPressLogin(_ sender: UIButton) {
    if(self.firstTextField.text?.characters.count == 1 && self.secondTextField.text?.characters.count == 1 && thridTextField.text?.characters.count == 1 && self.fourTextField.text?.characters.count == 1) {
      let a = Int(firstTextField.text!)
      let b = Int(secondTextField.text!)
      let c = Int(thridTextField.text!)
      let d = Int(fourTextField.text!)
      
      if (a == 1 && b == 2 && c == 3 && d == 4) {
        successAnimation()
      } else {
        wrongCodeAnimation()
      }
    }
    //call API Criptext
  }
}
