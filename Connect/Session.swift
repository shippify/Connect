//
//  Session.swift
//  Connect
//
//  Created by Kevin on 4/26/17.
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import RealmSwift

class Session: Object {
  dynamic var monkeyId = ""
  dynamic var name = ""
  dynamic var email = ""
  
  override static func primaryKey() -> String? {
    return "monkeyId"
  }
  
}
