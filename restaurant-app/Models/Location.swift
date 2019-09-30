//
//  Location.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct Location: Decodable {
  var countryId: Int
  var cityId: Int
  var zipCode: String
  var city: String
  var locality: String
  var address: String
  var lat: String
  var long: String
  
  init(countryId: Int, cityId: Int, zipCode: String, city: String, locality: String, address: String, lat: String, long: String) {
    self.countryId = countryId
    self.cityId = cityId
    self.zipCode = zipCode
    self.city = city
    self.locality = locality
    self.address = address
    self.lat = lat
    self.long = long
  }
  
  enum CodingKeys: String, CodingKey {
    case countryId = "country_id"
    case cityId = "city_id"
    case zipCode = "zipcode"
    case city = "city"
    case locality = "locality"
    case address = "address"
    case lat = "latitude"
    case long = "longitude"
  }
}
