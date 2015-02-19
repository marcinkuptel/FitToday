//
//  TodayViewController.swift
//  FitToday Widget
//
//  Created by Marcin Kuptel on 15/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var stepsLabel: UILabel!
    var progressView: UIView
    
    required init(coder aDecoder: NSCoder) {
        self.progressView = UIView(frame: CGRectZero)
        self.progressView.backgroundColor = UIColor.orangeColor()
        self.progressView.alpha = 0.5
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.view.addSubview(self.progressView)
        self.view.sendSubviewToBack(self.progressView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        let tokenKeeper = OAuthTokenKeeper()
        let fitBitClient = FitBitClient(tokenKeeper: tokenKeeper!)
        
        fitBitClient.getTimeSeries { (response, error) -> (Void) in
            if let err = error {
                completionHandler(NCUpdateResult.Failed)
            } else {
                if let responseObject = response {
                    self.stepsLabel.text = String(format: "Steps today: %@", responseObject.steps!)
                    self.updateProgressViewWithNumberOfSteps(responseObject.steps!.toInt())
                    completionHandler(NCUpdateResult.NewData)
                } else {
                    completionHandler(NCUpdateResult.NoData)
                }   
            }
        }
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    // MARK:- Progress view
    
    func updateProgressViewWithNumberOfSteps(stepsOptional: Int?) -> Void
    {
        if let steps = stepsOptional {
            
            let width = CGFloat(steps)/10000 * UIScreen.mainScreen().bounds.width
            
            let rect = CGRectMake(0, 0, width, self.view.frame.size.height)
            self.progressView.frame = rect
        }
    }
    
}
