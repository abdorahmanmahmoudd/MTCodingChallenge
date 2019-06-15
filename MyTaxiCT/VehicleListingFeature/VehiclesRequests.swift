//
//  VehiclesRequests.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
import Alamofire

// MARK: Enumeration of all of this module API requests
enum VehiclesRequests: Request {
    
    case fetchNearbyVehicles(p1Long: Double, p1Lat: Double, p2Long: Double, p2Lat: Double)
    
    var path: String {
        switch self {
        case let .fetchNearbyVehicles(p1Long: p1Long, p1Lat: p1Lat, p2Long: p2Long, p2Lat: p2Lat):
            return "?p2Lat=\(p1Long)&p1Lon=\(p1Lat)&p1Lat=\(p2Long)&p2Lon=\(p2Lat)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchNearbyVehicles:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchNearbyVehicles:
            return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchNearbyVehicles:
            return nil
        }
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringCacheData
    }
    
    var dataType: DataType {
        return DataType.JSON
    }
}
