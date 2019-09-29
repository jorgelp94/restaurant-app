//
//  SearchRouter.swift
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

@objc protocol SearchRoutingLogic {
  func routeToHomeViewController()
}

protocol SearchDataPassing {
  var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
  weak var viewController: SearchViewController?
  var dataStore: SearchDataStore?
  
  // MARK: Routing
  
  func routeToHomeViewController() {
    viewController?.navigationController?.navigationBar.isHidden = false
    viewController?.navigationController?.popViewController(animated: true)
  }
}
