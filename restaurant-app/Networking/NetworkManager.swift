//
//  NetworkManager.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkManager {
  static let manager: Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = TimeInterval(15)
    configuration.timeoutIntervalForResource = TimeInterval(30)
    
    let manager = Alamofire.SessionManager(configuration: configuration)
    return manager
  }()
  
  static let queue = DispatchQueue(label: "com.jorge.foodie", qos: .background, attributes: [.concurrent])
  static let headers = ["user-key": Constants.APIKeys.ZOMATO_API_KEY]
  
  static func requestPOST(host: String, params: [String: Any]?, completionHandler: @escaping (Data?, Error?) -> Void) {
    self.manager.request(host, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
      .validate(statusCode: 200..<300)
      .responseData(queue: queue) { (response) in
        DispatchQueue.main.async {
          switch response.result {
          case .success:
            completionHandler(response.data, nil)
          case .failure(let error):
            completionHandler(response.data, error)
          }
        }
    }
  }
  
  static func requestGET(host: String, params: [String: Any]?, completionHandler: @escaping (Data?, Error?) -> Void) {
    self.manager.request(host, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers)
      .validate(statusCode: 200..<300)
      .responseData(queue: queue) { (response) in
        DispatchQueue.main.async {
          switch response.result {
          case .success:
            completionHandler(response.data, nil)
          case .failure(let error):
            completionHandler(response.data, error)
          }
        }
    }
  }
}
