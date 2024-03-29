//
//  OnboardInteractor.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright (c) 2019 Jorge Luis Perales. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol OnboardBusinessLogic {
  func setOnboardFinished()
}

protocol OnboardDataStore {
  //var name: String { get set }
}

class OnboardInteractor: OnboardBusinessLogic, OnboardDataStore {
  var presenter: OnboardPresentationLogic?
  var worker =  OnboardWorker()
  
  // MARK: OnboardBusinessLogic
  
  func setOnboardFinished() {
    worker.completedOnboard()
  }
}
