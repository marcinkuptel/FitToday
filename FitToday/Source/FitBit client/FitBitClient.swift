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
    
    func getActivityStats(completion: (response: GetActivityStatsResponse, error: NSError?) -> (Void)) -> Void
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
                        completion(response: response, error: nil)
                    })
                }
            }
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
    
    /**
    This method contacts the FitBit server and retrieves the number of steps the user has taken.
    
    :param: completion Block called when a response has been received.
    */
    func getTimeSeries(completion: (response: GetTimeSeriesResponse?, error: NSError?) -> (Void)) -> Void
    {
        let request = FitBitRequestBuilder.getTimeSeriesRequest(self.tokenKeeper)
        let session = NSURLSession.sharedSession()
        
        let completionHandler = {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(response: nil, error: error)
                })
            } else {
                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                if responseString != nil {
                    let responseObject = GetTimeSeriesResponse(response: responseString!)
                    if let response = responseObject {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            completion(response: response, error: nil)
                        })
                        return
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(response: nil, error: nil)
                })
            }
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
        task.resume()
    }
}
