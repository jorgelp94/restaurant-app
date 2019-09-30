//
//  RestaurantListInteractor.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright (c) 2019 Jorge Luis Perales. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RestaurantListBusinessLogic {
  func getRestaurantsFromCollection(_ id: Int, _ start: Int)
}

protocol RestaurantListDataStore{
  //var name: String { get set }
}

class RestaurantListInteractor: RestaurantListBusinessLogic, RestaurantListDataStore {
  var presenter: RestaurantListPresentationLogic?
  var worker = RestaurantListWorker()
  //var name: String = ""
  
  // MARK: RestaurantListBusinessLogic
  
  func getRestaurantsFromCollection(_ id: Int, _ start: Int) {
    presenter?.presentActivityIndicator(true)
    worker.getRestaurantsFromCollection(id, start) { (data, error) in
      self.presenter?.presentActivityIndicator(false)
      if error == nil {
        guard let restaurants = data as? [Restaurant] else { return }
        self.presenter?.presentRestaurants(restaurants)
      } else {
        self.presenter?.presentError("Error", error!.localizedDescription)
      }
    }
  }
}
