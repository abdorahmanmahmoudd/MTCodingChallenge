//
//  APIClient.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/11/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
import Alamofire

typealias Success = (Decodable?) -> Void
typealias Failure = (Error?) -> Void

protocol APIClient {
    var baseUrl: String { get }
    var headers: [String: String]? { get }
    var errorModel: ConvertibleError { get }
    var validStatusCodes: [Int] { get }
    func fetch<T: Decodable>(request: Request, model: T, success: @escaping Success, failure: @escaping Failure)
    func checkNetworkState() -> Bool
}
