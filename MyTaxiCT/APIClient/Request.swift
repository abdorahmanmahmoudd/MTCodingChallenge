//
//  Request.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/11/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
import Alamofire

enum DataType {
    case JSON
    case data
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var dataType: DataType { get }
}
