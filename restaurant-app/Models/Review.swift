//
//  Review.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct Review: Decodable {
  var id: String
  var rating: String
  var text: String
  var date: String
  var user: User
  
  init(id: String, rating: String, text: String, date: String, user: User) {
    self.id = id
    self.rating = rating
    self.text = text
    self.date = date
    self.user = user
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case rating = "rating"
    case text = "review_text"
    case date = "timestamp"
    case user = "user"
  }
}
