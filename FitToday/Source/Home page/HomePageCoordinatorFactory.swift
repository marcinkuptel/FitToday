//
//  HomePageCoordinatorFactory.swift
//  FitToday
//
//  Created by Marcin Kuptel on 21/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class HomePageCoordinatorFactory: NSObject {

    class func homePageCoordinator() -> HomePageCoordinator?
    {
        let keeperOptional = OAuthTokenKeeper()
        
        if let keeper = keeperOptional
        {
            let client = FitBitClient(tokenKeeper: keeper)
            let coordinator = HomePageCoordinator(tokenKeeper: keeper, fitBitClient: client)
            return coordinator
        } else {
            return nil
        }
    }
}
