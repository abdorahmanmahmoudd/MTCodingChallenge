//
//  LocationBounds.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

@objc
class LocationBounds: NSObject {
    var point1Long: Double
    var point1Lat: Double
    var point2Long: Double
    var point2Lat: Double
    
    @objc
    init(point1Long: Double, point1Lat: Double, point2Long: Double, point2Lat: Double) {
        self.point1Long = point1Long
        self.point1Lat = point1Lat
        self.point2Long = point2Long
        self.point2Lat = point2Lat
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? LocationBounds {
            return self == rhs
        }
        return false
    }
    
    static func == (lhs: LocationBounds, rhs: LocationBounds) -> Bool {
        return (lhs.point1Lat == rhs.point1Lat &&
                lhs.point1Long == rhs.point1Long &&
                lhs.point2Lat == rhs.point2Lat &&
                lhs.point2Long == rhs.point2Long)
    }
    
}
