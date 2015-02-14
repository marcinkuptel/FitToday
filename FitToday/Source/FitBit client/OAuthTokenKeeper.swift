//
//  OAuthTokenKeeper.swift
//  FitToday
//
//  Created by Marcin Kuptel on 14/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class OAuthTokenKeeper: NSObject {

    let TOKEN_KEY = "token"
    let TOKEN_SECRET_KEY = "tokenSecret"
    
    /**
    Method saving token and token secret to NSUserDefaults.
    
    :param: token OAuth token received from the server.
    :param: tokenSecret OAuth token secret received from the server.
    */
    func saveTokenAndTokenSecret(token: String, tokenSecret: String) -> Void
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(token, forKey: TOKEN_KEY)
        defaults.setObject(tokenSecret, forKey: TOKEN_SECRET_KEY)
        defaults.synchronize()
    }
    
    func oauthToken() -> String?
    {
        return NSUserDefaults.standardUserDefaults().objectForKey(TOKEN_KEY) as String?
    }
    
    func oauthTokenSecret() -> String?
    {
        return NSUserDefaults.standardUserDefaults().objectForKey(TOKEN_SECRET_KEY) as String?
    }
    
    func authorized() -> Bool
    {
        return (self.oauthToken() != nil && self.oauthTokenSecret() != nil)
    }
}
