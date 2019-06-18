//
//  InteroperableMyTaxiAPI.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/16/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

typealias InteroperableSuccess = (NSCoding?) -> Void

// MARK: This protocol should be an interface for all the APIs
// but it does not work with objc
protocol MyTaxiAPI {
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping Success, failure: @escaping Failure)
}

// MARK: This protocol to be able to call api from Objective c and it replaces "MyTaxiAPI" protocol
@objc
protocol InteroperableMyTaxiAPI {
    @objc
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping InteroperableSuccess, failure: @escaping Failure)
}

// MARK: This class should have the real implementation of APIs
class RealAPI: NSObject, InteroperableMyTaxiAPI {}
