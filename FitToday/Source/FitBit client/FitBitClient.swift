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
    
    func getUserInfo() -> Void
    {
        let request = FitBitRequestBuilder.getUserInfoRequest(self.tokenKeeper)
        let session = NSURLSession.sharedSession()
        
        let completion = {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            if responseString != nil {
                let responseObject = GetUserInfoResponse(response: responseString!)
                println(responseObject?.fullName)
            }
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: completion)
        task.resume()
    }
    
}
