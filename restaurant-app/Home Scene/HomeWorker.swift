//
//  HomeWorker.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright (c) 2019 Jorge Luis Perales. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class HomeWorker {
  let requestManager = RequestManager.sharedInstance
  let networkStatus = NetworkStatus.sharedInstance
  
  func getCity(_ lat: Double, _ lon: Double, _ q: String, completionHandler: @escaping (Any?, Error?) -> Void) {
    let params = ["lat": lat, "lon": lon, "q": q] as [String : Any]
    if networkStatus.isOnline {
      requestManager.makeRequest(params: params, type: .city) { (data, error) in
        completionHandler(data, error)
      }
    } else {
      
    }
  }
  
  func isCountrySupported(_ country: String) -> Bool {
    // Hard coded supported countries from Zomato
    let supported = [
      "Australia",
      "Brasil",
      "Canada",
      "Chile",
      "Czech Republic",
      "India",
      "Indonesia",
      "Ireland",
      "Italy",
      "Lebanon",
      "Malaysia",
      "New Zealand",
      "Poland",
      "Portugal",
      "Qatar",
      "Singapore",
      "Slovakia",
      "South Africa",
      "Sri Lanka",
      "Turkey",
      "UAE",
      "United Kingdom",
      "United States"
    ]
    return supported.contains(country)
  }
  
  func getCityId() -> String? {
    return SessionManager.getCityId()
  }
}
