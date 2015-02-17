//
//  FitBitEndpoints.swift
//  FitToday
//
//  Created by Marcin Kuptel on 14/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

enum FitBitEndpoints {
    
    private static let baseURL = "https://api.fitbit.com"
    
    case GetUserInfo
    case GetActivityStats
    
    func URL() -> String {
        switch self {
        case .GetUserInfo:
            return FitBitEndpoints.baseURL + "/1/user/-/profile.json"
        case .GetActivityStats:
            return FitBitEndpoints.baseURL + "/1/user/-/activities.json"
        }
    }
}