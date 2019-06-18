//
//  MockVehicles.swift
//  MyTaxiCTTests
//
//  Created by Abdorahman Youssef on 6/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
@testable import MyTaxiCT

extension CoordinateObjc {
    static func with(lat: Double = 53.534996851868414,long: Double = 9.892590429911122) -> CoordinateObjc {
        return CoordinateObjc.init(fromDictionary: ["latitude": lat, "longitude": long])
    }
}

extension VehicleObjc {
    static func with(id: String = "633934", fleetType: String = "TAXI", heading: Double = 168.86792483590494) -> VehicleObjc {
        let coordinateDic = CoordinateObjc.with().toDictionary()
        return VehicleObjc.init(fromDictionary: ["id": id, "fleetType": fleetType, "heading": heading, "coordinate": coordinateDic])
    }
}

extension VehiclesObjc {
    static func with(numberOfVehicles: Int = 0 ) -> VehiclesObjc {
        var vehiclesListDictionary: [Any] = []
        
        for _ in 0..<numberOfVehicles {
            let vehicle = VehicleObjc.with()
            vehiclesListDictionary.append(vehicle.toDictionary())
        }
        return VehiclesObjc.init(fromDictionary: ["poiList": vehiclesListDictionary])
    }
}
