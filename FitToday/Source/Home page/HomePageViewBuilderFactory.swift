//
//  HomePageViewBuilderFactory.swift
//  FitToday
//
//  Created by Marcin Kuptel on 21/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class HomePageViewBuilderFactory: NSObject {

    class func homePageViewBuilder() -> HomePageViewBuilder?
    {
        let tokenKeeperOptional = OAuthTokenKeeper()
        
        if let tokenKeeper = tokenKeeperOptional
        {
            if tokenKeeper.authorized()
            {
                return HomePageAuthorizedBuilder()
            }
            else
            {
                return HomePageUnauthorizedBuilder()
            }
        }
        else
        {
            println(">>> Token keeper could not be instantiated")
            return nil
        }
    }
    
}
