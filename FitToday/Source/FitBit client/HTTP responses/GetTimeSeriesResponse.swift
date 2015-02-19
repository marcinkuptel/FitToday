//
//  GetTimeSeriesResponse.swift
//  FitToday
//
//  Created by Marcin Kuptel on 19/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class GetTimeSeriesResponse: HTTPResponse {

    lazy var steps: String? = {
        if let dict = self.dictionary {
            var activitiesStepsObject = dict["activities-steps"] as? [[String:AnyObject]]
            if let activitiesSteps = activitiesStepsObject {
                return activitiesSteps[0]["value"] as? String
            }
        }
        
        return nil
    }()
    
}
