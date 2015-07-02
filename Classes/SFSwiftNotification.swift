//
//  SFSwiftNotification.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

import UIKit

enum AnimationType {
    case AnimationTypeCollision
    case AnimationTypeBounce
}

struct AnimationSettings {
    var duration:NSTimeInterval = 0.5
    var delay:NSTimeInterval = 0
    var damping:CGFloat = 0.6
    var velocity:CGFloat = 0.9
    var elasticity:CGFloat = 0.3
}

enum Direction {
    case TopToBottom
    case LeftToRight
    case RightToLeft
}

protocol SFSwiftNotificationProtocol {
    func didNotifyFinishedAnimation(results: Bool)
    func didTapNotification()
}

class SFSwiftNotification: UIView, UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate {
    
    var label = UILabel()
    var animationType:AnimationType?
    var animationSettings = AnimationSettings()
    var direction:Direction?
    var dynamicAnimator = UIDynamicAnimator()
    var delegate: SFSwiftNotificationProtocol?
    var canNotify = true
    var offScreenFrame = CGRect()
    var toFrame = CGRect()
    var delay = NSTimeInterval()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, title: String?, animationType:AnimationType, direction:Direction, delegate: SFSwiftNotificationProtocol?) {
        super.init(frame: frame)
        
        self.animationType = animationType
        self.direction = direction
        self.delegate = delegate
        
        label = UILabel(frame: self.frame)
        label.text = title
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        
        // Create gesture recognizer to detect notification touches
        var tapReconizer = UITapGestureRecognizer()
        tapReconizer.addTarget(self, action: "invokeTapAction");
        
        // Add Touch recognizer to notification view
        self.addGestureRecognizer(tapReconizer)
        
        offScreen()
    }
    
    func invokeTapAction() {
        
        self.delegate!.didTapNotification()
        self.canNotify = true
    }
    
    func offScreen() {
        
        self.offScreenFrame = self.frame
        
        switch direction! {
        case .TopToBottom:
            self.offScreenFrame.origin.y = -self.frame.size.height
        case .LeftToRight:
            self.offScreenFrame.origin.x = -self.frame.size.width
        case .RightToLeft:
            self.offScreenFrame.origin.x = +self.frame.size.width
        }
        
        self.frame = offScreenFrame
    }
    
    func animate(toFrame:CGRect, delay:NSTimeInterval) {
        
        self.toFrame = toFrame
        self.delay = delay
        
        if canNotify {
            self.canNotify = false
            
            switch self.animationType! {
            case .AnimationTypeCollision:
                setupCollisionAnimation(toFrame)
                
            case .AnimationTypeBounce:
                setupBounceAnimation(toFrame, delay: delay)
            }
        }
    }
    
    func setupCollisionAnimation(toFrame:CGRect) {
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.superview!)
        self.dynamicAnimator.delegate = self
        
        let elasticityBehavior = UIDynamicItemBehavior(items: [self])
        elasticityBehavior.elasticity = animationSettings.elasticity;
        self.dynamicAnimator.addBehavior(elasticityBehavior)
        
        let gravityBehavior = UIGravityBehavior(items: [self])
        self.dynamicAnimator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [self])
        collisionBehavior.collisionDelegate = self
        self.dynamicAnimator.addBehavior(collisionBehavior)
        
        collisionBehavior.addBoundaryWithIdentifier("BoundaryIdentifierBottom", fromPoint: CGPointMake(-self.frame.width, self.frame.height+0.5), toPoint: CGPointMake(self.frame.width*2, self.frame.height+0.5))
        
        switch self.direction! {
        case .TopToBottom:
            break
        case .LeftToRight:
            collisionBehavior.addBoundaryWithIdentifier("BoundaryIdentifierRight", fromPoint: CGPointMake(self.toFrame.width-0.5, 0), toPoint: CGPointMake(self.toFrame.width-0.5, self.toFrame.height))
            gravityBehavior.gravityDirection = CGVectorMake(10, 1)
        case .RightToLeft:
            collisionBehavior.addBoundaryWithIdentifier("BoundaryIdentifierLeft", fromPoint: CGPointMake(+0.5, 0), toPoint: CGPointMake(+0.5, self.toFrame.height))
            gravityBehavior.gravityDirection = CGVectorMake(-10, 1)
        }
    }
    
    func setupBounceAnimation(toFrame:CGRect , delay:NSTimeInterval) {
        
        UIView.animateWithDuration(animationSettings.duration,
            delay: animationSettings.delay,
            usingSpringWithDamping: animationSettings.damping,
            initialSpringVelocity: animationSettings.velocity,
            options: (.BeginFromCurrentState | .AllowUserInteraction),
            animations:{
                self.frame = toFrame
            }, completion: {
                (value: Bool) in
                self.hide(toFrame, delay: delay)
            }
        )
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        
        hide(self.toFrame, delay: self.delay)
    }
    
    func hide(toFrame:CGRect, delay:NSTimeInterval) {
        
        UIView.animateWithDuration(animationSettings.duration,
            delay: delay,
            usingSpringWithDamping: animationSettings.damping,
            initialSpringVelocity: animationSettings.velocity,
            options: (.BeginFromCurrentState | .AllowUserInteraction),
            animations:{
                self.frame = self.offScreenFrame
            }, completion: {
                (value: Bool) in
                self.delegate!.didNotifyFinishedAnimation(true)
                self.canNotify = true
            }
        )
    }
}
