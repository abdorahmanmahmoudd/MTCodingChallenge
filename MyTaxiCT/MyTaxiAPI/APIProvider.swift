//
//  APIProvider.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/11/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

// MARK: This class routes between Real and Mock API providers
final class APIProvider: NSObject {
    
    var apiProvider: MyTaxiAPI
    
    init(apiProvider: MyTaxiAPI = RealAPI()) {
        self.apiProvider = apiProvider
    }
}

// MARK: This protocol should be an interface for all the APIs
protocol MyTaxiAPI {
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping Success, failure: @escaping Failure)
}

// MARK: This class should have the real implementation of APIs
class RealAPI: MyTaxiAPI {}

// MARK: This class should have Mocked implementation of APIs
//class MockAPI: MyTaxiAPI {}
