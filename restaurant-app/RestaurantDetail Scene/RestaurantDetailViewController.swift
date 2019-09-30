//
//  RestaurantDetailViewController.swift
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
import Cosmos
import NVActivityIndicatorView

protocol RestaurantDetailDisplayLogic: class {
  func displayActivityIndicator(_ show: Bool)
  func displayReviews(_ reviews: [Review])
  func displayError(_ title: String, _ message: String)
}

class RestaurantDetailViewController: UIViewController, RestaurantDetailDisplayLogic {
  var interactor: RestaurantDetailBusinessLogic?
  var router: (NSObjectProtocol & RestaurantDetailRoutingLogic & RestaurantDetailDataPassing)?

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var ratingView: CosmosView!
  @IBOutlet weak var reviewLabel: UILabel!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  var restaurant: Restaurant!
  var reviews = [Review]()
  var activityData = ActivityData()
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = RestaurantDetailInteractor()
    let presenter = RestaurantDetailPresenter()
    let router = RestaurantDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupNavBar()
    configureActivityIndicator()
    interactor?.getReviews(restaurant.id)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupView()
  }
  
  func setupTableView() {
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  func setupNavBar() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  func setupView() {
    self.segmentControl.tintColor = .foodyOrange
    self.titleLabel.text = self.restaurant.name
    self.restaurantImageView.af_setImage(withURL: URL(string: self.restaurant.thumb)!)
    self.reviewLabel.text = self.restaurant.rating.text
    self.reviewLabel.backgroundColor = self.restaurant.rating.color.toColor()
    self.reviewLabel.roundedCorners(radius: 5)
    self.ratingView.rating = Double(self.restaurant.rating.rating) as! Double
  }
  
  func configureActivityIndicator() {
    activityData = ActivityData(size: CGSize(width: 75, height: 75), message: nil, messageFont: nil, messageSpacing: nil, type: .ballPulse, color: .white, padding: 10, displayTimeThreshold: nil, minimumDisplayTime: 3, backgroundColor: nil, textColor: nil)
  }
  
  
  // MARK: RestaurantDetailViewController
  
  func displayActivityIndicator(_ show: Bool) {
    if show {
      NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    } else {
      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
  }
  
  func displayReviews(_ reviews: [Review]) {
    self.reviews = reviews
    self.tableView.reloadData()
  }
  
  func displayError(_ title: String, _ message: String) {
    Alert.errorAlert(view: self, title: title, message: message)
  }
  
  // MARK: IBActions
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    router?.routeToRestaurantList()
  }
  
  @IBAction func selectSegmentControl(_ sender: UISegmentedControl) {
    self.tableView.reloadData()
  }
  
}

extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.segmentControl.selectedSegmentIndex == 0 {
      return 2
    } else {
      return self.reviews.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if self.segmentControl.selectedSegmentIndex == 0 {
      if let cell =  tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoCell {
        if indexPath.row == 0 {
          cell.configure("Address", self.restaurant.location.address)
        } else {
          cell.configure("Timings", self.restaurant.timings)
        }
        return cell
      } else {
        return UITableViewCell()
      }
    } else {
      if let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ReviewCell {
        cell.configure(self.reviews[indexPath.row])
        return cell
      } else {
        return UITableViewCell()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if self.segmentControl.selectedSegmentIndex == 0 {
      return 117
    } else {
      return 234
    }
  }
}
