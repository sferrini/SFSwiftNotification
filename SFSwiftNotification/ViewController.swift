//
//  ViewController.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SFSwiftNotificationProtocol {
    
    var notificationView: SFSwiftNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationView = SFSwiftNotification(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50),
                                               title: "This is an SFSwiftNotification",
                                       animationType: .AnimationTypeBounce,
                                           direction: .RightToLeft,
                                            delegate: self)
        
        notificationView!.backgroundColor = UIColor.orangeColor()
        notificationView!.label.textColor = UIColor.whiteColor()
        
        self.view.addSubview(notificationView!)
    }
    
    @IBAction func notify(sender : AnyObject) {
        
        self.notificationView!.animate(1)
    }
    
    func didNotifyFinishedAnimation(results: Bool) {
        
        print("SFSwiftNotification finished animation")
    }
    
    func didTapNotification() {
        
        let tapAlert = UIAlertController(title: "SFSwiftNotification",
            message: "You just tapped the notificatoion",
            preferredStyle: .Alert)
        
        tapAlert.addAction(UIAlertAction(title: "OK",
            style: .Destructive,
            handler: nil))
        
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }

}

