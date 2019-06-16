//
//  VehicleAPI.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

extension APIProvider{
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping InteroperableeSuccess, failure: @escaping Failure) {
        apiProvider.fetchVehicles(withinBounds: bounds, success: success, failure: failure)
    }
}

// MARK: Vehicle APIs
extension RealAPI {
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping InteroperableeSuccess, failure: @escaping Failure) {
        let baseUrl = "https://fake-poi-api.mytaxi.com"
        let queryUrl = "\(baseUrl)?p2Lat=\(bounds.point2Lat)&p1Lon=\(bounds.point1Long)&p1Lat=\(bounds.point1Lat)&p2Lon=\(bounds.point2Long)"
        
        guard let query = queryUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: query) else {
            let error = ErrorCase.notFound
            return failure(error)
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            if let data = data {
                
                if let serializedJson = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  {
                    
                    if let mutableContainer = serializedJson as? [String: Any]{
                        
                        let model = VehiclesObjc.init(fromDictionary:  mutableContainer)
                        
                        DispatchQueue.main.async {
                            success(model)
                        }
                        
                    }else{
                        let myTaxiError = MyTaxiError.init()
                        myTaxiError.errorMessage = "Failed to parse response data"
                        let error = ErrorCase.generic(errorModel: myTaxiError)
                        DispatchQueue.main.async {
                            failure(error)
                        }
                    }
                }
            }
        }
        
        task.resume()
        
    }

}

//class MockVehicleAPI: VehicleAPI {
//    func fetchVehicles(p1Long: Float, p1Lat: Float, p2Long: Float, p2Lat: Float, success: @escaping Success, failure: @escaping Failure) {
//        success(nil)
//    }
//}

