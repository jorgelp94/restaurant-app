//
//  Alert.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation
import UIKit

class Alert: NSObject {
  
  class func singleActionAlert(view: UIViewController, title: String, message: String, completion: @escaping (UIAlertAction) -> Void) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
      completion(action)
    }
    alertController.addAction(okAction)
    DispatchQueue.main.async {
      view.present(alertController, animated: true, completion: nil)
    }
  }
  
  class func errorAlert(view: UIViewController, title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: title, style: .default, handler: nil)
    alertController.addAction(okAction)
    DispatchQueue.main.async {
      view.present(alertController, animated: true, completion: nil)
    }
  }
  
  class func multipleActionAlert(view: UIViewController, title: String, message: String, okTitle: String, completion: @escaping (Bool) -> Void) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: okTitle, style: .default) { (action) in
      completion(true)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      completion(false)
    }
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    DispatchQueue.main.async {
      view.present(alertController, animated: true, completion: nil)
    }
  }
}
