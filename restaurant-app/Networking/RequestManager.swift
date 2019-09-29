//
//  RequestManager.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation
import SwiftyJSON

final class RequestManager {
  
  static let sharedInstance = RequestManager()
  
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
  
  func getCity(params: [String: Any]?, completionHandler: @escaping ([City]?, Error?) -> Void) {
    let url = Endpoints.Cities.fetch.url
    NetworkManager.requestGET(host: url, params: params) { (data, error) in
      if let data = data {
        let response = JSON(data)
        do {
          if let suggestions = try? response["location_suggestions"].rawData() {
            let cities = try JSONDecoder().decode([City].self, from: suggestions)
            completionHandler(cities, nil)
          }
        } catch (let error) {
          completionHandler(nil, error)
        }
      } else {
        completionHandler(nil, error)
      }
    }
  }
}
