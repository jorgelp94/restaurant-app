//
//  RequestManager.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

final class RequestManager {
  static let sharedinstance = RequestManager()
  
  func makeRequest(params: [String: Any]?,
                   type: TypeRequest,
                   completionHandler: @escaping (Any?, Error?) -> Void) {
    switch type {
    case .city:
      self.getCity(params: params) { (data, error) in
        completionHandler(data, error)
      }
    default: break
    }
  }
  
  func getCity(params: [String: Any]?, completionHandler: @escaping (String?, Error?) -> Void) {
    let url = Endpoints.Cities.fetch.url
    NetworkManager.requestGET(host: url, params: params) { (data, error) in
      print(data)
      print(error)
    }
  }
}
