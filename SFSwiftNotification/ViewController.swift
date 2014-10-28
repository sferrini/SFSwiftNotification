//
//  ViewController.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SFSwiftNotificationProtocol {
    
    var notifyFrame:CGRect?
    var notifyView:SFSwiftNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        notifyFrame = CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)
        notifyView = SFSwiftNotification(frame: notifyFrame!,
                                         title: nil,
                                 animationType: AnimationType.AnimationTypeCollision,
                                     direction: Direction.LeftToRight,
                                      delegate: self)
        notifyView!.backgroundColor = UIColor.orangeColor()
        notifyView!.label.textColor = UIColor.whiteColor()
        notifyView!.label.text = "This is an SFSwiftNotification"
        self.view.addSubview(notifyView!)
    }
    
    @IBAction func notify(sender : AnyObject) {
        
        self.notifyView!.animate(notifyFrame!, delay: 1)
    }
    
    func didNotifyFinishedAnimation(results: Bool) {
        
        println("SFSwiftNotification finished animation")
    }
    
    func didTapNotification() {
        
        let tapAlert = UIAlertController(title: "SFSwiftNotification",
            message: "You just tapped the notificatoion",
            preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

