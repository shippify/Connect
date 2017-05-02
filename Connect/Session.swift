//
//  Session.swift
//  Connect
//
//  Created by Kevin on 5/2/17.
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import Foundation
import RealmSwift

class Session: Object {
  dynamic var monkeyId = ""
  dynamic var name = ""
  dynamic var email = ""
  
  override static func primaryKey() -> String? {
    return "monkeyId"
  }
  
}
