//
//  City.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct City: Decodable {
  var id: Int
  var name: String
  var country: String
  var state: String
  var stateCode: String
  
  init(id: Int, name: String, country: String, state: String, stateCode: String) {
    self.id = id
    self.name = name
    self.country = country
    self.state = state
    self.stateCode = stateCode
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case country = "country_name"
    case state = "state_name"
    case stateCode = "state_code"
  }
}
