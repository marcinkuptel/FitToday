//
//  GetActivityStatsResponse.swift
//  FitToday
//
//  Created by Marcin Kuptel on 17/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class GetActivityStatsResponse: HTTPResponse {

    lazy var steps: Int? = {
        if let dict = self.dictionary {
            var bestObject = dict["best"] as? [String:AnyObject]
            if let best = bestObject {
                var totalObject = best["total"] as? [String:AnyObject]
                if let total = totalObject {
                    var stepsObject = total["steps"] as? [String:AnyObject]
                    if let steps = stepsObject {
                        return steps["value"] as? Int
                    }
                }
            }
        }
        
        return nil
    }()
    

}
