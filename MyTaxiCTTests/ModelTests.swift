//
//  ModelTests.swift
//  MyTaxiCTTests
//
//  Created by Abdorahman Youssef on 6/15/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import XCTest
@testable import MyTaxiCT

typealias JSON = Dictionary<String, Any>

class ModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulInit() {
        
        let coordinateJson: JSON = ["latitude": 53.58500747958, "longitude": 9.807045083858156 ]
        
        let testSuccessfulJSON: JSON = ["id": 1,
                                        "fleetType": "Taxi",
                                        "heading": 71.63840043828,
                                        "coordinate": coordinateJson]
        
        XCTAssertNotNil(Vehicle(json: testSuccessfulJSON))
    }

}

private extension Vehicle{
    init?(json: JSON) {
        guard let id = json["id"] as? Int,
            let fleetType = json["fleetType"] as? String,
            let heading = json["heading"] as? Double,
            let coordinateJson = json["coordinate"] as? JSON,
            let coordinate = Coordinate.init(json: coordinateJson) else {
                return nil
        }
        self.id = id
        self.fleetType = fleetType
        self.heading = heading
        self.coordinate = coordinate
    }
}

private extension Coordinate{
    init?(json: JSON) {
        guard let latitude = json["latitude"] as? Double,
            let longitude = json["longitude"] as? Double else {
                return nil
        }
        self.latitude = latitude
        self.longitude = longitude
    }
}
