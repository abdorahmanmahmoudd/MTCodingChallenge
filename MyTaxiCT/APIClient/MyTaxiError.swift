//
//  MyTaxiError.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/11/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

protocol ConvertibleError: Decodable {
    func convert(withStatusCode code: NSInteger?, errorModel: Decodable?) -> Error
    func convertPayload(withData data: Data?) -> Decodable?
}

enum ErrorCase: Error {
    case noInternetConnection
    case notFound
    case internalServerError
    case forbidden
    case timeOut
    case irrecoverable
    case generic(errorModel: Decodable?)
}

enum ErrorCode: Int {
    case timeOut = 504
    case irrecoverable = 999
    case forbidden = 403
    case internalServerError = 500
    case notFound = 404
    case generic = 400
}

class MyTaxiError: ConvertibleError {
    
    var errorCode: Int
    var errorMessage: String
    
    init() {
        errorCode = ErrorCode.irrecoverable.rawValue
        errorMessage = ""
    }
    
    func convert(withStatusCode code: NSInteger?, errorModel: Decodable?) -> Error {
        
        var error: ErrorCase?
        
        switch code {
        case ErrorCode.internalServerError.rawValue:
            error = ErrorCase.internalServerError
            
        case ErrorCode.notFound.rawValue:
            error = ErrorCase.notFound
            
        case ErrorCode.timeOut.rawValue:
            error = ErrorCase.timeOut
            
        case ErrorCode.forbidden.rawValue:
            error = ErrorCase.forbidden
            
        case ErrorCode.generic.rawValue:
            error = ErrorCase.generic(errorModel: errorModel)
            
        default:
            error = ErrorCase.irrecoverable
        }
        
        return error ?? ErrorCase.irrecoverable
    }
    
    func convertPayload(withData data: Data?) -> Decodable? {
        if let usableData = data {
            let errorModel = try? JSONDecoder().decode(MyTaxiError.self, from: usableData)
            print("Error model: \(String(describing: errorModel))\n")
            return errorModel
        }
        return nil
    }
    
}
