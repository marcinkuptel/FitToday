//
//  HomePageAuthorizedBuilder.swift
//  FitToday
//
//  Created by Marcin Kuptel on 21/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class HomePageAuthorizedBuilder: NSObject, HomePageViewBuilder
{
    func buildViewAndCoordinator() -> (UIView, HomePageCoordinator)
    {
        //view
        let view = self.buildView()
        
        //coordinator
        let tokenKeeper = OAuthTokenKeeper()!
        let client = FitBitClient(tokenKeeper: tokenKeeper)
        let coordinator = HomePageAuthorizedCoordinator()
        
        return (view, coordinator)
    }
    
    private func buildView() -> UIView
    {
        let view = UIView()
        view.backgroundColor = UIColor.greenColor()
        return view
    }
}
