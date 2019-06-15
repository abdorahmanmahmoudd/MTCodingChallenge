//
//  VehicleAPI.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

extension APIProvider{
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping Success, failure: @escaping Failure) {
        apiProvider.fetchVehicles(withinBounds: bounds, success: success, failure: failure)
    }
}

// MARK: Vehicle APIs
extension RealAPI {
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping Success, failure: @escaping Failure) {
        let fetchVehiclesRequest = VehiclesRequests.fetchNearbyVehicles(p1Long: bounds.point1Long, p1Lat: bounds.point1Lat, p2Long: bounds.point2Long, p2Lat: bounds.point2Lat)
        SharedClient.fetchRequest(withRequest: fetchVehiclesRequest, andModel: Vehicles(), success: success, failure: failure)
    }
}

//class MockVehicleAPI: VehicleAPI {
//    func fetchVehicles(p1Long: Float, p1Lat: Float, p2Long: Float, p2Lat: Float, success: @escaping Success, failure: @escaping Failure) {
//        success(nil)
//    }
//}

