//
//  SearchInteractor.swift
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

protocol SearchBusinessLogic {
  func getCities(search: String)
  func verifySelection(_ id: String)
}

protocol SearchDataStore {
  //var name: String { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
  var presenter: SearchPresentationLogic?
  var worker = SearchWorker()
  //var name: String = ""
  
  // MARK: SearchBusinessLogic
  
  func getCities(search: String) {
    self.presenter?.presentActivityIndicator(true)
    worker.getCity(search) { (data, error) in
      self.presenter?.presentActivityIndicator(false)
      if error == nil  {
        guard let cities = data as? [City] else { return }
        self.presenter?.presentCities(cities)
      } else {
        self.presenter?.presentError("Error", error!.localizedDescription)
      }
    }
  }
  
  func verifySelection(_ id: String) {
    worker.setCityId(id)
    presenter?.presentHomeViewController()
  }
}
