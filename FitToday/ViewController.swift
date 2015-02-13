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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // OAuth1.0
        let oauthswift = OAuth1Swift(
            consumerKey:    "ba97b4e675d54c46bb3148b5e0d16cca",
            consumerSecret: "2e9ddb630ad84d4fbec689e7acd4f444",
            requestTokenUrl: "https://api.fitbit.com/oauth/request_token",
            authorizeUrl:    "https://www.fitbit.com/oauth/authorize",
            accessTokenUrl:  "https://api.fitbit.com/oauth/access_token"
        )
        
        
        let failure = {
            (error) -> Void in
            
        }
        
        oauthswift.authorizeWithCallbackURL(NSURL(string: "oauth-swift://oauth-callback/twitter")!,
            success: {
                            credential, response in
                            println(credential.oauth_token)
                            println(credential.oauth_token_secret)
                            }) { (error) -> Void in
                                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

