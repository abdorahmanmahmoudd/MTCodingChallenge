//
//  VehiclesTableViewModelTests.swift
//  MyTaxiCTTests
//
//  Created by Abdorahman Youssef on 6/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import XCTest
import RxSwift
@testable import MyTaxiCT

class VehiclesTableViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNormalVehicleCells(){
        let disposeBag = DisposeBag()
        let mockAPIClient = MockMyTaxiAPI()
        mockAPIClient.expectedResults = .success(payload: VehiclesObjc.with(numberOfVehicles: 1))
        
        let viewModel = VehiclesTableViewModel.init(myAPI: mockAPIClient)
        viewModel.fetchNearbyVehicles()
        
        let expectNormalVehicleCellCreated = expectation(description: "Vehicle cells contains a normal cell")
        
        viewModel.cells.subscribe(
            onNext: {
                let firstCellIsNormal: Bool
                if case .some(.normal(_)) = $0.first{
                    firstCellIsNormal = true
                }else {
                    firstCellIsNormal = false
                }
                
                XCTAssertTrue(firstCellIsNormal)
                expectNormalVehicleCellCreated.fulfill()
                
        }).disposed(by: disposeBag)
        wait(for: [expectNormalVehicleCellCreated], timeout: 0.1)
    }

}
