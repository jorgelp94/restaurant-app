//
//  User.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct User: Decodable {
  var name: String
  var profileImage: String
  
  init(name: String, profileImage: String) {
    self.name = name
    self.profileImage = profileImage
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case profileImage = "profile_image"
  }
}
