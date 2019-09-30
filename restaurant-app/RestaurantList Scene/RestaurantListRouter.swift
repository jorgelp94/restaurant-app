//
//  RestaurantListRouter.swift
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

@objc protocol RestaurantListRoutingLogic {
  
}

protocol RestaurantListDataPassing {
  var dataStore: RestaurantListDataStore? { get }
}

class RestaurantListRouter: NSObject, RestaurantListRoutingLogic, RestaurantListDataPassing {
  weak var viewController: RestaurantListViewController?
  var dataStore: RestaurantListDataStore?
  
  // MARK: Routing
  
}