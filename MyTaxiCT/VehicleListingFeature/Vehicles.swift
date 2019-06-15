//
//  Vehicles.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

struct Vehicles: Decodable {
    
    var vehicles: [Vehicle] = []
    
    private enum CodingKeys: String, CodingKey {
        case vehicles = "poiList"
    }
}

struct Vehicle: Decodable {
    
    var id: Int?
    var coordinate: Coordinate?
    var fleetType: String?
    var heading: Double?
}


struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
