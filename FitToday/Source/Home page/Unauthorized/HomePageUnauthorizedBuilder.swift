//
//  HomePageUnauthorizedBuilder.swift
//  FitToday
//
//  Created by Marcin Kuptel on 21/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class HomePageUnauthorizedBuilder: NSObject, HomePageViewBuilder {

    func buildViewAndCoordinator() -> (UIView, HomePageCoordinator)
    {
        //Coordinator
        let tokenKeeper = OAuthTokenKeeper()!
        let client = FitBitClient(tokenKeeper: tokenKeeper)
        let coordinator = HomePageUnauthorizedCoordinator(tokenKeeper: tokenKeeper, fitBitClient: client)
        
        //View
        let view = self.buildView(coordinator)
        
        return (view, coordinator)
    }
    
    private func buildView(coordinator: HomePageUnauthorizedCoordinator) -> UIView
    {
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor.redColor()
        
        let button = UIButton()
        button.setTitle("Authorize", forState: UIControlState.Normal)
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.addTarget(coordinator, action: "authorizeButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        let horizontalConstraints = self.buttonHorizontalConstraints(button)
        view.addConstraints(horizontalConstraints)
        
        let verticalConstraints = self.buttonVerticalConstraints(button)
        view.addConstraints(verticalConstraints)
        
        return view
    }
    
    private func buttonHorizontalConstraints(button: UIButton) -> [NSLayoutConstraint]
    {
        let views = ["button":button]
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[button]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        return constraints as [NSLayoutConstraint]
    }
    
    private func buttonVerticalConstraints(button: UIButton) -> [NSLayoutConstraint]
    {
        let views = ["button":button]
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[button]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views)
        
        return constraints as [NSLayoutConstraint]
    }
}
