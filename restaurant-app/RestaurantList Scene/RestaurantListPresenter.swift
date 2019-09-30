//
//  RestaurantListPresenter.swift
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

protocol RestaurantListPresentationLogic {
  func presentActivityIndicator(_ show: Bool)
  func presentRestaurants(_ restaurants: [Restaurant])
  func presentError(_ title: String, _ message: String)
}

class RestaurantListPresenter: RestaurantListPresentationLogic {
  weak var viewController: RestaurantListDisplayLogic?
  
  // MARK: RestaurantListPresentationLogic
  
  func presentActivityIndicator(_ show: Bool) {
    viewController?.displayActivityIndicator(show)
  }
  
  func presentRestaurants(_ restaurants: [Restaurant]) {
    viewController?.displayRestaurants(restaurants)
  }
  
  func presentError(_ title: String, _ message: String) {
    viewController?.displayError(title, message)
  }
}
