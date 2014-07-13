//
//  ViewController.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SFSwiftNotificationProtocol {
    
    let notifyViewHeight:CGFloat = 50
    var notifyFrame:CGRect?
    var notifyView:SFSwiftNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        notifyFrame = CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), notifyViewHeight)
        notifyView = SFSwiftNotification(frame: notifyFrame!, title: nil, delegate: self)
        notifyView!.backgroundColor = UIColor.orangeColor()
        notifyView!.label.textColor = UIColor.whiteColor()
        notifyView!.label.text = "This is an SFSwiftNotification"
        self.view.addSubview(notifyView)
    }
    
    @IBAction func notify(sender : AnyObject) {
        
        var notifyToFrame:CGRect = notifyFrame!
        notifyToFrame.origin.y = 0
        self.notifyView!.animate(notifyToFrame, delay: 1)
    }
    
    func didNotifyFinishedAnimation(results: Bool) {
        
        println("SFSwiftNotification finished animation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

