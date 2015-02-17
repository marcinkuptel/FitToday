//
//  FitBitClient.swift
//  FitToday
//
//  Created by Marcin Kuptel on 14/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class FitBitClient: NSObject {

    private let tokenKeeper: OAuthTokenKeeper
    
    init(tokenKeeper: OAuthTokenKeeper) {
        self.tokenKeeper = tokenKeeper
    }
    
    func getUserInfo(completion: (response: GetUserInfoResponse) -> (Void)) -> Void
    {
        let request = FitBitRequestBuilder.getUserInfoRequest(self.tokenKeeper)
        let session = NSURLSession.sharedSession()
        
        let completionHandler = {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            if responseString != nil {
                let responseObject = GetUserInfoResponse(response: responseString!)
                if let response = responseObject {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(response: response)
                    })
                }
            }
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
    func getActivityStats(completion: (response: GetActivityStatsResponse) -> (Void)) -> Void
    {
        let request = FitBitRequestBuilder.getActivityStatsRequest(self.tokenKeeper)
        let session = NSURLSession.sharedSession()
        
        let completionHandler = {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            if responseString != nil {
                let responseObject = GetActivityStatsResponse(response: responseString!)
                if let response = responseObject {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(response: response)
                    })
                }
            }
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
}
