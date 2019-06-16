//
//  APIProvider.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/11/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

// MARK: This class routes between Real and Mock API providers
final class APIProvider: NSObject {
    
    var apiProvider: InteroperableMyTaxiAPI
    
    init(apiProvider: InteroperableMyTaxiAPI = RealAPI()) {
        self.apiProvider = apiProvider
    }
}
