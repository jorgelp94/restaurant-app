//
//  RequestManager.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation
import SwiftyJSON

final class RequestManager {
  
  static let sharedInstance = RequestManager()
  
  func makeRequest(params: [String: Any]?,
                   type: TypeRequest,
                   completionHandler: @escaping (Any?, Error?) -> Void) {
    switch type {
    case .city:
      self.getCity(params: params) { (data, error) in
        completionHandler(data, error)
      }
    case .collections:
      self.getCollections(params: params) { (data, error) in
        completionHandler(data, error)
      }
    case .restaurantCollections:
      self.getRestaurantsFromCollection(params: params) { (data, error) in
        completionHandler(data, error)
      }
    case .reviews:
      self.getReviews(params: params) { (data, error) in
        completionHandler(data, error)
      }
    case .nearby:
      self.getRestaurantsFromCollection(params: params) { (data, error) in
        completionHandler(data, error)
      }
    default: break
    }
  }
  
  private func getCity(params: [String: Any]?, completionHandler: @escaping ([City]?, Error?) -> Void) {
    let url = Endpoints.Cities.fetch.url
    NetworkManager.requestGET(host: url, params: params) { (data, error) in
      if let data = data {
        let response = JSON(data)
        do {
          if let suggestions = try? response["location_suggestions"].rawData() {
            let cities = try JSONDecoder().decode([City].self, from: suggestions)
            completionHandler(cities, nil)
          }
        } catch (let error) {
          completionHandler(nil, error)
        }
      } else {
        completionHandler(nil, error)
      }
    }
  }
  
  private func getCollections(params: [String: Any]?, completionHandler: @escaping ([Collection]?, Error?) -> Void) {
    let url = Endpoints.Collections.fetch.url
    NetworkManager.requestGET(host: url, params: params) { (data, error) in
      if let data = data {
        let response = JSON(data)
        var collectionArray = [Collection]()
        do {
          if let suggestions = try? response["collections"].rawData() {
            let collections = try JSONDecoder().decode([[String: Collection]].self, from: suggestions)
            for item in collections {
              collectionArray.append(item["collection"]!)
            }
            completionHandler(collectionArray, nil)
          }
        } catch (let error) {
          completionHandler(nil, error)
        }
      } else {
        completionHandler(nil, error)
      }
    }
  }
  
  private func getRestaurantsFromCollection(params: [String: Any]?, completionHandler: @escaping ([Restaurant]?, Error?) -> Void) {
    let url = Endpoints.Search.fetch.url
    NetworkManager.requestGET(host: url, params: params) { (data, error) in
      if let data = data {
        let response = JSON(data)
        var restaurantArray = [Restaurant]()
        var reviews = [Review]()
        do {
          if let suggestions = try? response["restaurants"].rawData() {
            let restaurants = try JSONDecoder().decode([[String: Restaurant]].self, from: suggestions)
            for item in restaurants {
              restaurantArray.append(item["restaurant"]!)
            }
//            if let restautantJSON = response["restaurants"].array {
//              for restaurant in restautantJSON {
//                print("🙈")
//                print(restaurant["establishment"])
//                if let reviews = try? restaurant["all_reviews"].rawData() {
//                  let reviews = try JSONDecoder().decode([[String: Review]].self, from: reviews)
//                  print("ALL REVIEWS")
//                  print(reviews)
//                } else {
//                  print("NO REVIEWS")
//                }
//              }
//            }
            completionHandler(restaurantArray, nil)
          }
        } catch (let error) {
          completionHandler(nil, error)
        }
      } else {
        completionHandler(nil, error)
      }
    }
  }
  
  private func getReviews(params: [String: Any]?, completionHandler: @escaping ([Review]?, Error?) -> Void) {
    let url = Endpoints.Reviews.fetch.url
    NetworkManager.requestGET(host: url, params: params) { (data, error) in
      if let data = data {
        let response = JSON(data)
        var reviewArray = [Review]()
        do {
          if let suggestions = try? response["user_reviews"].rawData() {
            let reviews = try JSONDecoder().decode([[String: Review]].self, from: suggestions)
            for item in reviews {
              reviewArray.append(item["review"]!)
            }
            completionHandler(reviewArray, nil)
          }
        } catch (let error) {
          completionHandler(nil, error)
        }
      } else {
        completionHandler(nil, error)
      }
    }
  }
}
