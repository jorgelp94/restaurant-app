//
//  Rating.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct Rating: Decodable {
  var rating: String
  var text: String
  var color: String
  
  init(rating: String, text: String, color: String) {
    self.rating = rating
    self.text = text
    self.color = color
  }
  
  enum CodingKeys: String, CodingKey {
    case rating = "aggregate_rating"
    case text = "rating_text"
    case color = "rating_color"
  }
}
