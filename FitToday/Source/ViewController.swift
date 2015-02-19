//
//  ViewController.swift
//  FitToday
//
//  Created by Marcin Kuptel on 13/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {
    
    let tokenKeeper: OAuthTokenKeeper! = OAuthTokenKeeper()
    let fitBitClient: FitBitClient
    
    required init(coder aDecoder: NSCoder) {
        self.fitBitClient = FitBitClient(tokenKeeper: self.tokenKeeper)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.tokenKeeper.authorized() {

            let oauthswift = OAuth1Swift(
                consumerKey:        OAuthConstants.ConsumerKey.rawValue,
                consumerSecret:     OAuthConstants.ConsumerSecret.rawValue,
                requestTokenUrl:    OAuthConstants.RequestTokenURL.rawValue,
                authorizeUrl:       OAuthConstants.AuthorizeURL.rawValue,
                accessTokenUrl:     OAuthConstants.AccessTokenURL.rawValue
            )
            
            let failure = {
                (error: NSError) -> Void in
                println("Authorization failed: \(error)")
            }
            
            let success = {
                (credential: OAuthSwiftCredential, response: NSURLResponse) in
                self.tokenKeeper.saveTokenAndTokenSecret(credential.oauth_token, tokenSecret: credential.oauth_token_secret)
            }
            
            oauthswift.authorizeWithCallbackURL(NSURL(string: "oauth-swift://oauth-callback/fitbit")!,
                success: success, failure: failure)
        } else {
            self.fitBitClient.getUserInfo({ (response) -> (Void) in
                println("\(response.fullName?)")
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

