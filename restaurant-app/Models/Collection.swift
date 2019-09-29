//
//  Collection.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct Collection: Decodable {
  var id: Int
  var resCount: Int
  var imageUrl: String
  var url: String
  var title: String
  
  init(id: Int, resCount: Int, imageUrl: String, url: String, title: String) {
    self.id = id
    self.resCount = resCount
    self.imageUrl = imageUrl
    self.url = url
    self.title = title
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "collection_id"
    case resCount = "res_count"
    case imageUrl = "image_url"
    case url = "url"
    case title = "title"
  }
}
