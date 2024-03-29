//
//  HomeViewController.swift
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
import CoreLocation
import NVActivityIndicatorView

protocol HomeDisplayLogic: class {
  func displayActivityIndicator(_ show: Bool)
  func displayCities(_ cities: [City])
  func displayError(_ title: String, _ message: String)
  func displayCollections(_ collections: [Collection])
  func displayRestaurants(_ restaurants: [Restaurant])
}

class HomeViewController: UIViewController, HomeDisplayLogic {
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

  @IBOutlet weak var collectionsCollectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  
  let locationManager = CLLocationManager()
  var activityData = ActivityData()
  var collections = [Collection]()
  var restaurants = [Restaurant]()
  
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
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
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
    
    self.locationManager.delegate = self
    setupNavBar()
    setupCollectionView()
    setupActivityIndicator()
    setupTableView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupLocation()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
    self.navigationController?.navigationBar.isHidden = false
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func setupNavBar() {
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    self.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.navigationBar.largeTitleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 30) ?? UIFont.systemFont(ofSize: 30)
    ]
    self.navigationController?.navigationBar.barTintColor = .foodyOrange
  }
  
  func setupCollectionView() {
    self.collectionsCollectionView.delegate = self
    self.collectionsCollectionView.dataSource = self
  }
  
  func setupTableView() {
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  func setupActivityIndicator() {
    activityData = ActivityData(size: CGSize(width: 75, height: 75), message: nil, messageFont: nil, messageSpacing: nil, type: .ballPulse, color: .white, padding: 10, displayTimeThreshold: nil, minimumDisplayTime: 3, backgroundColor: nil, textColor: nil)
  }
  
  func setupLocation() {
    if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined:
        locationManager.requestAlwaysAuthorization()
      case .authorizedAlways, .authorizedWhenInUse:
        self.handleLocationAllowed()
      case .restricted, .denied:
        self.handleLocationRestricted()
      }
    } else {
      print("location services are not enabled")
    }
  }
  
  func getPlace(location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
    let geoCoder = CLGeocoder()
    geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
      guard error == nil else {
        print("Error: ", error)
        completion(nil)
        return
      }
      
      guard let placemark = placemarks?[0] else {
        print("Error: ", error)
        completion(nil)
        return
      }
      
      completion(placemark)
    }
  }
  
  func handleLocationAllowed() {
    let location = self.locationManager.location!
    getPlace(location: location) { (placemark) in
      if let country = placemark?.country {
        guard let supported = self.interactor?.verifySupportedCountry(country) else {
          // TODO: Add city selection dialog
          return
        }
        
        if let _ = self.interactor?.getLocalCityId() {
          self.interactor?.getCollections()
          self.interactor?.getNearbyRestaurants(0)
        } else {
          if supported  {
            if let town = placemark?.locality {
              // TODO: Add city selection dialog
              self.interactor?.getCity(lat: location.coordinate.latitude, lon: location.coordinate.longitude, city: town)
            }
          } else {
            // TODO: hide content from home
            let title = "Country not supported"
            let message = "Please search for another city."
            Alert.singleActionAlert(view: self, title: title, message: message, completion: { (action) in
              self.router?.routeToSearchController()
            })
          }
        }
      }
    }
  }
  
  func handleLocationRestricted() {
    if let _ = self.interactor?.getLocalCityId() {
      self.interactor?.getCollections()
      self.interactor?.getNearbyRestaurants(0)
    } else {
      let title = "Select a city"
      let message = "You will need to select a city in order to give you nearby restaurants."
      Alert.singleActionAlert(view: self, title: title, message: message, completion: { (action) in
        self.router?.routeToSearchController()
      })
    }
  }
  
  // MARK: HomeDisplayLogic
  
  func displayActivityIndicator(_ show: Bool) {
    if show {
      NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    } else {
      NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
  }
  
  func displayCities(_ cities: [City]) {
    router?.routeToCitySelection(cities)
  }
  
  func displayError(_ title: String, _ message: String) {
    Alert.errorAlert(view: self, title: title, message: message)
  }
  
  func displayCollections(_ collections: [Collection]) {
    self.collections = collections
    self.collectionsCollectionView.reloadData()
  }
  
  func displayRestaurants(_ restaurants: [Restaurant]) {
    self.restaurants = restaurants
    self.tableView.reloadData()
  }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.collections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell {
      cell.configure(self.collections[indexPath.row])
      return cell
    } else {
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let collection = self.collections[indexPath.row]
    router?.routeToRestaurantListController(collection.id, collection.title)
  }
  
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.restaurants.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as? RestaurantCell {
      cell.configureCell(self.restaurants[indexPath.row])
      return cell
    } else {
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let restaurant = self.restaurants[indexPath.row]
    router?.routeToRestaurantDetail(restaurant)
  }
}

extension HomeViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    setupLocation()
  }
}
