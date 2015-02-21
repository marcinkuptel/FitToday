//
//  ViewController.swift
//  FitToday
//
//  Created by Marcin Kuptel on 13/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let state: (view:UIView, coordinator:HomePageCoordinator)
    
    required init(coder aDecoder: NSCoder)
    {
        let builder = HomePageViewBuilderFactory.homePageViewBuilder()!
        self.state = builder.buildViewAndCoordinator()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.state.view.frame = self.view.bounds
        self.view.addSubview(self.state.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

