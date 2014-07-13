//
//  SFSwiftNotification.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

import UIKit

struct Animation {
    var duration:NSTimeInterval = 0.5
    var delay:NSTimeInterval = 0
    var damping:CGFloat = 0.4
    var velocity:CGFloat = 0.3
}

protocol SFSwiftNotificationProtocol {
    func didNotifyFinishedAnimation(results: Bool)
}

class SFSwiftNotification: UIView {
    
    var label = UILabel()
    var delegate: SFSwiftNotificationProtocol?
    var animation = Animation()
    var canNotify = true
    
    init(frame: CGRect, title: NSString?, delegate: SFSwiftNotificationProtocol?) {
        super.init(frame: frame)
        
        self.delegate = delegate
        
        label = UILabel(frame: self.frame)
        label.text = title
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        
        offScreen()
    }
    
    func offScreen() {
        
        var offScreenFrame = self.frame
        offScreenFrame.origin.y = -self.frame.size.height
        self.frame = offScreenFrame
    }
    
    func animate(toFrame:CGRect, delay:NSTimeInterval) {
        
        if canNotify {
            self.canNotify = false
            UIView.animateWithDuration(animation.duration,
                delay: animation.delay,
                usingSpringWithDamping: animation.damping,
                initialSpringVelocity: animation.velocity,
                options: (.BeginFromCurrentState | .AllowUserInteraction),
                animations:{
                    self.frame = toFrame
                }, completion: {
                    (value: Bool) in
                    self.hide(toFrame, delay: delay)
                }
            )
        }
    }
    
    func hide(toFrame:CGRect, delay:NSTimeInterval) {
        
        UIView.animateWithDuration(animation.duration,
            delay: delay,
            usingSpringWithDamping: animation.damping,
            initialSpringVelocity: animation.velocity,
            options: (.BeginFromCurrentState | .AllowUserInteraction),
            animations:{
                var hideFrame = toFrame
                hideFrame.origin.y = toFrame.origin.y-self.frame.size.height
                self.frame = hideFrame
            }, completion: {
                (value: Bool) in
                self.delegate!.didNotifyFinishedAnimation(true)
                self.canNotify = true
            }
        )
    }
}
