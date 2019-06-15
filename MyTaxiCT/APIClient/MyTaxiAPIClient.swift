//
//  MyTaxiAPIClient.swift
//  MyTaxiCT
//
//  Created by Abdorahman Youssef on 6/13/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
import Alamofire

// MARK: This class should be used to excute real api calls
class MyTaxiAPIClient: APIClient {
    
    var baseUrl: String {
        return "https://fake-poi-api.mytaxi.com"
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var errorModel: ConvertibleError{
        return MyTaxiError.init()
    }
    
    var validStatusCodes: [Int] {
        return Array(200 ..< 300)
    }
}

// MARK: Fetch requests method to process different kind of requests
extension MyTaxiAPIClient{
    
    func fetch<T>(request: Request, model: T, success: @escaping Success, failure: @escaping Failure) where T: Decodable {
        
        guard checkNetworkState() else {
            let error: ErrorCase = ErrorCase.noInternetConnection
            failure(error)
            return
        }
        
        var fullUrl: String = request.path
        if !fullUrl.contains(baseUrl) { // To handle different base url case
            fullUrl = "\(baseUrl)\(fullUrl)"
        }
        fullUrl = fullUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? fullUrl
        
        var headerPerRequest = headers
        if request.headers != nil {
            for header in request.headers! {
                headerPerRequest?[header.key] = header.value
            }
        }
        
        var encode: ParameterEncoding
        switch request.method {
        case HTTPMethod.get:
            encode = URLEncoding(destination: .queryString)
        default:
            encode = JSONEncoding.default
        }
        
        guard let encodedRequest = encodeRequest(withURL: fullUrl, method: request.method,
                                                 parameters: request.parameters,
                                                 encoding: encode,
                                                 headers: headerPerRequest,
                                                 cachePolicy: request.cachePolicy) else {
                                                    return
        }
        
        Alamofire.SessionManager.default.request(encodedRequest)
            .validate(statusCode: validStatusCodes)
            .responseJSON { response in
                
                if let error = response.result.error {
                    print(error as Any)
                } else {
                    print(response.result.value as Any)
                }
                self.mapResponse(response: response, errorModel: self.errorModel, model: model, success: success, failure: failure)
        }
    }
    
    func checkNetworkState() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    @discardableResult
    func encodeRequest(withURL url: URLConvertible,
                       method: HTTPMethod = .get,
                       parameters: Parameters? = nil,
                       encoding: ParameterEncoding = URLEncoding.default,
                       headers: HTTPHeaders? = nil,
                       cachePolicy: URLRequest.CachePolicy) -> URLRequest?{
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = cachePolicy
            
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            
            return encodedURLRequest
        } catch {
            return nil
        }
    }
}

// MARK: Map response result logic
extension MyTaxiAPIClient{
    
    func mapResponse<T: Decodable>(response: DataResponse<Any>, errorModel: ConvertibleError, model: T,  success: @escaping Success, failure: @escaping Failure) {
        switch response.result {
            
        case let .success(response):
            mapSuccessResponseResult(withResponse: response, andModel: model, andSuccessBlock: success)
            
        case let .failure(error):
            mapFailureResponseResult(withResponseData: response.data, withResponseError: error, andErrorModel: errorModel, andFailureBlock: failure)
        }
    }
    
    func mapSuccessResponseResult<T: Decodable>(withResponse response: Any, andModel model: T, andSuccessBlock success: @escaping Success) {
        do{
            if let jsonData = response as? [String: Any] {
                let jsonObject = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                let model = try JSONDecoder().decode(T.self, from: jsonObject)
                success(model)
                
            } else if let jsonData = response as? [Any] {
                let jsonObject = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                let model = try JSONDecoder().decode([T].self, from: jsonObject)
                success(model)
            }
            else{
                // TODO: May want to handle this case!
            }
            
        } catch let error{
            print(error)
        }
    }
    
    func mapFailureResponseResult(withResponseData responseData: Data?, withResponseError responseError: Error, andErrorModel errorModel: ConvertibleError, andFailureBlock failure: @escaping Failure) {
        
        var errorCode: Int?
        var mappedError: Decodable?
        
        if let alamoFireError = responseError as? AFError {
            errorCode = alamoFireError.responseCode
        } else {
            let nsError: NSError = responseError as NSError
            errorCode = nsError.code
        }
        
        mappedError = errorModel.convertPayload(withData: responseData)
        let myTaxiError = errorModel.convert(withStatusCode: errorCode, errorModel: mappedError)
        failure(myTaxiError)
    }
}
