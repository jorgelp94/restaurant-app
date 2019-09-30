//
//  ReviewCell.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/29/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCell: UITableViewCell {
  
  @IBOutlet weak var mainView: UIView!
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var ratingView: CosmosView!
  @IBOutlet weak var textView: UITextView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(_ review: Review) {
    self.mainView.roundedCorners(radius: 10)
    self.usernameLabel.text = review.user.name
    self.textView.text = review.text
    self.ratingView.rating = Double(review.rating) as! Double
    self.userImageView.af_setImage(withURL: URL(string: review.user.profileImage)!)
  }
}
