//
//  Globals.swift
//  Connect
//
//  Created by Kevin on 5/4/17.
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

let APIID = ""
let APISECRET = ""

let baseURL = ""
let testingURL = ""

import Foundation
import UIKit
import Lottie

var rootViewController : RotationNavigationController = {
  return UIStoryboard.viewController(identifier: "Main") as! RotationNavigationController
}()

var leftViewController: SlideMenuViewController = {
  return UIStoryboard.viewController(identifier: "Menu") as! SlideMenuViewController
}()

extension UIView {
  
  public func initialAnimation(){
    let animationView = LOTAnimationView(name: "animation")
    animationView?.contentMode = UIViewContentMode.scaleAspectFit
    animationView?.center = center
    animationView?.backgroundColor = UIColor.white
    addSubview(animationView!)
    
    animationView?.alpha = 1
    
    animationView?.play(completion: { finished in
      animationView?.alpha = 0
    })
  }
  
}

extension String {
  
  var localized: String {
    return NSLocalizedString(self, comment: "Comment")
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
