//
//  HTTPResponse.swift
//  FitToday
//
//  Created by Marcin Kuptel on 15/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class HTTPResponse: NSObject {

    private var response: String = ""
    var dictionary: [String:AnyObject]?
    
    convenience init?(response: String)
    {
        self.init()
        self.response = response
        var convertedToData = response.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        if let data = convertedToData {
            var error: NSError?
            var object: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error)
            if object == nil {
                println("Could not convert string to JSON. Error: \(error)")
                return nil
            } else {
                self.dictionary = object as? [String:AnyObject]
            }
        } else {
            return nil
        }
    }
    
}
    