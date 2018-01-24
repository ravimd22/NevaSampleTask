//
//  UserProfileResultsModel.swift
//  NevaSampleTask
//
//  Created by Basavaraj D on 24/01/18.
//  Copyright © 2018 Ravi D. All rights reserved.
//

import UIKit
import ObjectMapper

class UserProfileResultsModel: Mappable {

    var code : Int?
    var message : String?
    var data : [UserProfileInfoModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map ["code"]
        message <- map["message"]
        data <- map["data"]
    }
}


class UserProfileInfoModel: Mappable {
    
    var id : Int?
    var name : String?
    var skills : String?
    var image : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        skills <- map["skills"]
        image <- map["image"]
    }
    
}
