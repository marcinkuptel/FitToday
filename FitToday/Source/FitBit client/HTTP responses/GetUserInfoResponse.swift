//
//  GetUserInfoResponse.swift
//  FitToday
//
//  Created by Marcin Kuptel on 15/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class GetUserInfoResponse: HTTPResponse {

    var fullName: String? {
        get {
            if let dict = self.dictionary {
                var userObject = dict["user"] as? [String:AnyObject]
                if let user = userObject {
                    return user["fullName"] as? String
                } else {
                    return nil
                }
            } else {
                return nil
            }
            
        }
    }
    
}
