//
//  SessionManager.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

final class SessionManager {
  
  private static let userDefaults = UserDefaults.standard
  
  static func clear() {
    let dictionary = userDefaults.dictionaryRepresentation()
    for (key, _) in dictionary {
      self.userDefaults.removeObject(forKey: key)
    }
    userDefaults.synchronize()
  }
  
  static func setUserCompletedOnboard(_ completed: Bool) {
    self.userDefaults.set(completed, forKey: "completed_onboard")
  }
  
  static func getUserCompletedOnboard() -> Bool {
    return self.userDefaults.bool(forKey: "completed_onboard")
  }
  
  static func setCityId(_ id: String) {
    self.userDefaults.set(id, forKey: "city_id")
  }
  
  static func getCityId() -> String? {
    return self.userDefaults.string(forKey: "city_id")
  }
}
