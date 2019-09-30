//
//  RestaurantCell.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import UIKit
import Cosmos

class RestaurantCell: UITableViewCell {
  
  @IBOutlet weak var mainView: UIView!
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var cuisinesLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var ratingView: CosmosView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configureCell(_ restaurant: Restaurant) {
    self.mainView.roundedCorners(radius: 10)
    self.thumbImageView.roundedCorners(radius: 10)
    self.ratingLabel.roundedCorners(radius: 5)
    self.ratingLabel.backgroundColor = restaurant.rating.color.toColor()
    
    self.titleLabel.text = restaurant.name
    self.cuisinesLabel.text = restaurant.cuisines
    self.ratingLabel.text = restaurant.rating.text
    self.ratingView.rating = Double(restaurant.rating.rating) as! Double
    if restaurant.thumb != "" && restaurant.thumb != nil {
      self.thumbImageView.af_setImage(withURL: URL(string: restaurant.thumb)!)
    }
  }
  
}
