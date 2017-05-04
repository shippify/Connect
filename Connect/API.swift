//
//  API.swift
//  Connect
//
//  Created by Kevin on 5/4/17.
//  Copyright © 2017 Criptext Inc. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

public enum Either<T, U: Error> {
  case success(T)
  case failure(U)
}


public enum CriptextAPIError: Error {
  case unknown
}

public struct API  {
  
  public static func sign(_ username: String, completion: @escaping(Either<Void, CriptextAPIError>) -> ()) -> Request {
    let urlString = "https://secure.criptext.com/v1.1/users/sign"
    let parameters = [
      "username":username
    ]
    
    return request(urlString, method: .post, parameters: parameters).authenticate(user: globalVariables.APIID, password: globalVariables.APISECRET).responseData(completionHandler: { (response) in
      switch response.result {
      case .success(let data):
        let result: Either<Void, CriptextAPIError>
        do {
          let status = response.response?.statusCode
          if status == 200 {
            result = .success()
          } else {
            result = .failure(.unknown)
          }
          completion(result)
        } catch {
          result = .failure(.unknown)
        }
        completion(result)
      case .failure(let error):
        print(error)
        completion(.failure(.unknown))
      }
    })
  }
  
  public static func auth(_ username:String, code:String, completion: @escaping(Either<String, CriptextAPIError>) ->()) -> Request {
    let urlString = "https://secure.criptext.com/v1.1/users/auth"
    let parameters = [
      "username": username,
      "code": code
    ]
    
    return request(urlString, method: .post, parameters: parameters).responseData { (response) in
      switch response.result {
      case .success(let data):
        let result: Either<String, CriptextAPIError>
        do {
        let status = response.response?.statusCode
        if status == 200 {
          let monkeyID: String = try Unboxer.performCustomUnboxing(data: data, closure: { $0.unbox(key: "user.id") })
          result = .success(monkeyID)
        } else {
          result = .failure(.unknown)
        }
        } catch {
          result = .failure(.unknown)
        }
        completion(result)
      case .failure(let error):
        print(error)
        completion(.failure(.unknown))
      }
    }
  }
}
