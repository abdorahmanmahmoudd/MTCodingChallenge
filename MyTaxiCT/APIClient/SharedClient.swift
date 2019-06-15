//
//  SharedClient.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

// MARK: This class can be used to mock the API Client it self and generally it should be shared between all the APIs
final class SharedClient {
    
    static private var apiClient: APIClient = MyTaxiAPIClient()
    
    private init() {}
    
    static func setAPIClient(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    static func fetchRequest<T: Decodable>(withRequest request: Request, andModel model: T, success: @escaping Success, failure: @escaping Failure){
        apiClient.fetch(request: request, model: model, success: success, failure: failure)
    }
    
}
