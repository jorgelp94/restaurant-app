//
//  NetworkStatus.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

final class NetworkStatus {
  static let sharedInstance = NetworkStatus()
  var isOnline = false
  
  private init() { }
  
  let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
  
  func startNetworkReachabilityObserver() {
    if (Alamofire.NetworkReachabilityManager()?.isReachable)! {
      self.isOnline = true
    }
    
    reachabilityManager?.listener = { status in
      
      switch status {
      case .notReachable:
        self.isOnline = false
        print("The network is not reachable")
        
      case .unknown :
        self.isOnline = false
        print("It is unknown whether the network is reachable")
        
      case .reachable(.ethernetOrWiFi):
        self.isOnline = true
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Online"), object: nil)
        print("The network is reachable over the WiFi connection")
        
      case .reachable(.wwan):
        self.isOnline = true
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Online"), object: nil)
        print("The network is reachable over the WWAN connection")
        
      }
    }
    reachabilityManager?.startListening()
  }
}
