//
//  API.swift
//  restaurant-app
//
//  Created by Jorge Luis Perales on 9/28/19.
//  Copyright © 2019 Jorge Luis Perales. All rights reserved.
//

import Foundation

struct API {
  static let baseUrl = Constants.ZOMATO_URL
}

protocol Endpoint {
  var path: String { get }
  var url: String { get }
}

enum Endpoints {
  
  enum Collections: Endpoint {
    case fetch
    
    public var path: String {
      switch self {
      case .fetch: return "/collections"
      }
    }
    
    public var url: String {
      switch self {
      case .fetch: return "\(API.baseUrl)\(path)"
      }
    }
  }
  
  enum Cities: Endpoint {
    case fetch
    
    public var path: String {
      switch self {
      case .fetch: return "/cities"
      }
    }
    
    public var url: String {
      switch self {
      case .fetch: return "\(API.baseUrl)\(path)"
      }
    }
  }
  
  enum Restaurant: Endpoint {
    case fetch
    
    public var path: String {
      switch self {
      case .fetch: return "/restaurant"
      }
    }
    
    public var url: String {
      switch self {
      case .fetch: return "\(API.baseUrl)\(path)"
      }
    }
  }
  
  enum Reviews: Endpoint {
    case fetch
    
    public var path: String {
      switch self {
      case .fetch: return "/reviews"
      }
    }
    
    public var url: String {
      switch self {
      case .fetch: return "\(API.baseUrl)\(path)"
      }
    }
  }
  
  enum Search: Endpoint {
    case fetch
    
    public var path: String {
      switch self {
      case .fetch: return "/search"
      }
    }
    
    public var url: String {
      switch self {
      case .fetch: return "\(API.baseUrl)\(path)"
      }
    }
  }
}
