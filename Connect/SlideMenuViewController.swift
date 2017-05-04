//
//  SlideMenuViewController.swift
//  Connect
//
//  Created by Kevin on 5/3/17.
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import MonkeyKit

final class SlideMenuViewController: UIViewController {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var logoutButton: UIButton!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let session = Session.current else { fatalError() }
    
    nameLabel.text = session.email
    profileImage.image = UIImage(named: "Profile_imgDefault")
    logoutButton.titleLabel?.text = "Log Out"
    
    setupViews()
  }
  
  func setupViews(){
    
    profileImage.layer.cornerRadius = 50
    profileImage.layer.masksToBounds = true
    profileImage.contentMode = .scaleAspectFill
    
    logoutButton.layer.cornerRadius = 5
    logoutButton.layer.borderWidth = 2
    logoutButton.layer.borderColor = UIColor.red.cgColor
    logoutButton.layer.masksToBounds = true
    
  }
  
  @IBAction func logOutSession(_ sender: UIButton) {
    
    UIApplication.shared.unregisterForRemoteNotifications()
    Monkey.sharedInstance().close()
    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
    let initialViewController = UIStoryboard.viewController(identifier: "Start")
    UIApplication.shared.keyWindow?.rootViewController = initialViewController
  }
}
