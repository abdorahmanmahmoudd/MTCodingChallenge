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
    
    func testEmptyVehicleCells(){
        let disposeBag = DisposeBag()
        let mockAPIClient = MockMyTaxiAPI()
        mockAPIClient.expectedResults = .success(payload: VehiclesObjc.with(numberOfVehicles: 0))
        
        let viewModel = VehiclesTableViewModel.init(myAPI: mockAPIClient)
        viewModel.fetchNearbyVehicles()
        
        let expectEmptyCellCreated = expectation(description: "Vehicle cells contains an empty cell")
        
        viewModel.cells.subscribe(
            onNext: {
                let firstCellIsEmpty: Bool
                
                if case .some(.empty) = $0.first{
                    firstCellIsEmpty = true
                }else {
                    firstCellIsEmpty = false
                }
                
                XCTAssertTrue(firstCellIsEmpty)
                expectEmptyCellCreated.fulfill()
                
        }).disposed(by: disposeBag)
        wait(for: [expectEmptyCellCreated], timeout: 0.1)
    }
    
    func testErrorVehicleCells(){
        let disposeBag = DisposeBag()
        let mockAPIClient = MockMyTaxiAPI()
        mockAPIClient.expectedResults = Result.failure(ErrorCase.notFound)
        
        let viewModel = VehiclesTableViewModel.init(myAPI: mockAPIClient)
        viewModel.fetchNearbyVehicles()
        
        let expectErrorCellCreated = expectation(description: "Vehicle cells an error cell")
        
        viewModel.cells.subscribe(
            onNext: {
                let firstCellIsError: Bool
                
                if case .some(.error) = $0.first{
                    firstCellIsError = true
                }else {
                    firstCellIsError = false
                }
                
                XCTAssertTrue(firstCellIsError)
                expectErrorCellCreated.fulfill()
                
        }).disposed(by: disposeBag)
        wait(for: [expectErrorCellCreated], timeout: 0.1)
    }
    
    //MARK: test vehicle cell view model
    func testVehicleCellAddress(){
        let disposeBag = DisposeBag()
        let mockAPIClient = MockMyTaxiAPI()
        mockAPIClient.expectedResults = .success(payload: VehiclesObjc.with(numberOfVehicles: 1))
        
        let viewModel = VehiclesTableViewModel.init(myAPI: mockAPIClient)
        viewModel.fetchNearbyVehicles()
        
        let expectVehicleModelToFetchAddress = expectation(description: "Vehicle Model fetched the address")
        
        viewModel.cells.subscribe(
            onNext: {
                var cellModelFetchedAddress: Bool = false
                if case .some(let .normal(cellModel)) = $0.first{
                    
                    cellModel.address.asObservable().subscribe(onNext: { (value) in
                        if !value.isEmpty && value != "Car address: ..."{
                            cellModelFetchedAddress = true
                        }
                        
                        self.wait(interval: 4.0, completion: {
                            XCTAssertTrue(cellModelFetchedAddress)
                            expectVehicleModelToFetchAddress.fulfill()
                        })
                        
                    }).disposed(by: disposeBag)
                }
                
        }).disposed(by: disposeBag)
        wait(for: [expectVehicleModelToFetchAddress], timeout: 5.0)
    }
    
    // helper method to test complex async calls
    func wait(interval: TimeInterval = 0.1 , completion: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            completion()
        }
    }

}



private final class MockMyTaxiAPI: InteroperableMyTaxiAPI {
    
    var expectedResults: Result<VehiclesObjc, ErrorCase>?
    
    func fetchVehicles(withinBounds bounds: LocationBounds, success: @escaping InteroperableSuccess, failure: @escaping Failure) {
        switch self.expectedResults {
        case .success(let vehicles)?:
            success(vehicles)
        case .failure(let error)?:
            failure(error)
        case .none:
            failure(ErrorCase.notFound)
        }
    }
    
}
