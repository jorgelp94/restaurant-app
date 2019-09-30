//
//  Restaurant.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
  var id: String
  var name: String
  var url: String
  var cuisines: String
  var thumb: String
  var location: Location
  var rating: Rating
  var timings: String
  
  init(id: String, name: String, url: String, cuisines: String, thumb: String, timings: String, location: Location, rating: Rating) {
    self.id = id
    self.name = name
    self.url = url
    self.cuisines = cuisines
    self.thumb = thumb
    self.location = location
    self.rating = rating
    self.timings = timings
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case url = "url"
    case cuisines = "cuisines"
    case thumb = "thumb"
    case location
    case rating = "user_rating"
    case timings = "timings"
  }
}
