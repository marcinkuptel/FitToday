//
//  ViewController.swift
//  FitToday
//
//  Created by Marcin Kuptel on 13/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeCoordinator: HomePageCoordinator?
    
    required init(coder aDecoder: NSCoder)
    {
        self.homeCoordinator = HomePageCoordinatorFactory.homePageCoordinator()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let coordinator = self.homeCoordinator
        {
            coordinator.authorizeIfNeeded({ (success, error) -> (Void) in
                if success {
                    println(">>> App authorized")
                } else {
                    println(">>> Authorization failed: \(error)")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

