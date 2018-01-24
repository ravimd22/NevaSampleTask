//
//  APIManager.swift
//  NevaSampleTask
//
//  Created by Basavaraj D on 24/01/18.
//  Copyright © 2018 Ravi D. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


class APIManager: NSObject {

    static let sharedInstance = APIManager()
    
    public func GETRequest(success:@escaping (UserProfileResultsModel, Int?) -> Void, failure:@escaping (String?,Int?) -> Void)
    {
        let urlString = ConfigKeys.BaseURL.rawValue
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        Alamofire.request(urlString,headers:headers).responseJSON { response in
            if response.result.isSuccess{
                let  model : UserProfileResultsModel = Mapper<UserProfileResultsModel>().map(JSONObject: response.result.value)!
                success(model, 200)
            }else{
                
                guard case let .failure(error) = response.result else { return }
                
                if let error = error as? AFError {
                    failure(error.errorDescription, 0)
                } else if let error = error as? URLError {
                    failure(error.localizedDescription, 0)
                } else {
                    failure(error.localizedDescription, 0)
                }
            }
            
           
        }

    }
    
}
