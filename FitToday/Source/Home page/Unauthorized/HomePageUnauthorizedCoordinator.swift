//
//  HomePageUnauthorizedCoordinator.swift
//  FitToday
//
//  Created by Marcin Kuptel on 21/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation
import OAuthSwift

class HomePageUnauthorizedCoordinator: NSObject, HomePageCoordinator {

    let tokenKeeper: OAuthTokenKeeper
    let fitBitClient: FitBitClient
    
    init(tokenKeeper: OAuthTokenKeeper, fitBitClient: FitBitClient)
    {
        self.fitBitClient = fitBitClient
        self.tokenKeeper = tokenKeeper
        super.init()
    }
    
    func authorizeButtonPressed(sender: UIButton) -> Void
    {
        self.authorizeIfNeeded { (success, error) -> (Void) in
            if success
            {
                
            }
            else
            {
                
            }
        }
    }
    
    //MARK: Authorization
    
    /**
    This method performs authrization with the fitbit server. If successful,
    OAuth token and token secret are received.
    
    :param: Completion block informing the caller whether authorization was successful.
    */
    func authorizeIfNeeded(completion: (success: Bool, error: NSError?) -> (Void)) -> Void
    {
        if !self.tokenKeeper.authorized()
        {
            let oauthswift = OAuth1Swift(
                consumerKey:        OAuthConstants.ConsumerKey.rawValue,
                consumerSecret:     OAuthConstants.ConsumerSecret.rawValue,
                requestTokenUrl:    OAuthConstants.RequestTokenURL.rawValue,
                authorizeUrl:       OAuthConstants.AuthorizeURL.rawValue,
                accessTokenUrl:     OAuthConstants.AccessTokenURL.rawValue
            )
            
            let failure = {
                (error: NSError) -> Void in
                completion(success: false, error: error)
            }
            
            let success = {
                (credential: OAuthSwiftCredential, response: NSURLResponse) -> Void in
                self.tokenKeeper.saveTokenAndTokenSecret(credential.oauth_token, tokenSecret: credential.oauth_token_secret)
                completion(success: true, error: nil)
            }
            
            oauthswift.authorizeWithCallbackURL(NSURL(string: "oauth-swift://oauth-callback/fitbit")!,
                success: success, failure: failure)
            
        } else {
            completion(success: true, error:nil)
        }
    }

}
