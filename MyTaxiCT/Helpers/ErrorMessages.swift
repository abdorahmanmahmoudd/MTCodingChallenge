//
//  ErrorMessages.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/16/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation


func getErrorMessage(error: Error?) -> String{
    
    guard let error = error as? ErrorCase else{
        return "Unknown error"
    }
    
    switch error {
    case .generic:
        break
    case .noInternetConnection:
        return "There is no internet connection"
    case .notFound:
        break
    case .internalServerError:
        break
    case .forbidden:
        break
    case .timeOut:
        break
    case .irrecoverable:
        break
    }
    return "Unknown error"
}
