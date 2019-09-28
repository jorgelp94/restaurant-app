//
//  UIVIew.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func roundedCorners(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
  }
}
