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
