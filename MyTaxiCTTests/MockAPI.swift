//
//  MockAPI.swift
//  MyTaxiCTTests
//
//  Created by Abdorahman Youssef on 6/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

@testable import MyTaxiCT

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}

enum EmptyResult<U: Error> {
    case success
    case failure(U?)
}


final class MockMyTaxiAPI: InteroperableMyTaxiAPI {
    
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
