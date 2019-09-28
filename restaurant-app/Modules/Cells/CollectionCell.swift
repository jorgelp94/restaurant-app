//
//  CollectionCell.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
  @IBOutlet weak var mainView: UIView!
  @IBOutlet weak var collectionImageView: UIImageView!
  @IBOutlet weak var overlayView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  func configure() {
    self.overlayView.backgroundColor = .black
    self.overlayView.roundedCorners(radius: 10)
    self.mainView.roundedCorners(radius: 10)
    self.collectionImageView.roundedCorners(radius: 10)
  }
}
