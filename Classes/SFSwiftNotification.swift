//
//  SFSwiftNotification.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2016 sferrini. All rights reserved.
//

import UIKit

enum AnimationType {
    case Collision
    case Bounce
}

enum AnimationDirection {
    case TopToBottom
    case LeftToRight
    case RightToLeft
}

struct AnimationSettings {
    var duration: NSTimeInterval = 0.5
    var delay: NSTimeInterval = 0
    var damping: CGFloat = 0.6
    var velocity: CGFloat = 0.9
    var elasticity: CGFloat = 0.3
}

protocol SFSwiftNotificationProtocol {
    func didNotifyFinishedAnimation(results: Bool)
    func didTapNotification()
}

class SFSwiftNotification: UIView {
    
    var label = UILabel()
    
    private var animationType: AnimationType?
    private var animationSettings = AnimationSettings()
    private var direction: AnimationDirection?
    private var dynamicAnimator = UIDynamicAnimator()
    private var delegate: SFSwiftNotificationProtocol?
    private var canNotify = true
    private var offScreenFrame = CGRect()
    private var toFrame = CGRect()
    private var initialFrame = CGRect()
    private var delay = NSTimeInterval()
    
    init(frame: CGRect, title: String?, animationType: AnimationType, direction: AnimationDirection, delegate: SFSwiftNotificationProtocol?) {
        super.init(frame: frame)
        
        self.animationType = animationType
        self.direction = direction
        self.delegate = delegate
        self.initialFrame = frame
        
        label = UILabel(frame: self.frame)
        label.text = title
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        
        // Create gesture recognizer to detect notification touches
        let tapReconizer = UITapGestureRecognizer()
        tapReconizer.addTarget(self, action: "invokeTapAction");
        
        // Add Touch recognizer to notification view
        self.addGestureRecognizer(tapReconizer)
        
        offScreen()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(delay: NSTimeInterval) {
        
        self.toFrame = self.frame
        self.delay = delay
        
        if canNotify {
            self.canNotify = false
            
            switch self.animationType! {
            case .Collision:
                setupCollisionAnimation(self.initialFrame)
                
            case .Bounce:
                setupBounceAnimation(self.initialFrame, delay: delay)
            }
        }
    }
    
    func invokeTapAction() {
        
        self.delegate!.didTapNotification()
        self.canNotify = true
    }
    
    private func offScreen() {
        
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
    
    private func setupCollisionAnimation(toFrame: CGRect) {
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.superview!)
        self.dynamicAnimator.delegate = self
        
        let elasticityBehavior = UIDynamicItemBehavior(items: [self])
        elasticityBehavior.elasticity = animationSettings.elasticity;
        self.dynamicAnimator.addBehavior(elasticityBehavior)
        
        let gravityBehavior = UIGravityBehavior(items: [self])
        self.dynamicAnimator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [self])
        self.dynamicAnimator.addBehavior(collisionBehavior)
        
        collisionBehavior.addBoundaryWithIdentifier("BoundaryIdentifierBottom", fromPoint: CGPointMake(-self.frame.width, self.frame.height), toPoint: CGPointMake(self.frame.width*2, self.frame.height))
        
        switch self.direction! {
        case .TopToBottom:
            break
        case .LeftToRight:
            collisionBehavior.addBoundaryWithIdentifier("BoundaryIdentifierRight", fromPoint: CGPointMake(self.toFrame.width+1, 0), toPoint: CGPointMake(self.toFrame.width+2, self.toFrame.height))
            gravityBehavior.gravityDirection = CGVectorMake(10, 1)
        case .RightToLeft:
            collisionBehavior.addBoundaryWithIdentifier("BoundaryIdentifierLeft", fromPoint: CGPointMake(-1, 0), toPoint: CGPointMake(-2, self.toFrame.height))
            gravityBehavior.gravityDirection = CGVectorMake(-10, 1)
        }
    }
    
    private func setupBounceAnimation(toFrame: CGRect , delay: NSTimeInterval) {
        
        UIView.animateWithDuration(animationSettings.duration,
            delay: animationSettings.delay,
            usingSpringWithDamping: animationSettings.damping,
            initialSpringVelocity: animationSettings.velocity,
            options: ([.BeginFromCurrentState, .AllowUserInteraction]),
            animations:{
                self.frame = toFrame
            }, completion: {
                (value: Bool) in
                self.hide(toFrame, delay: delay)
            }
        )
    }
    
    private func hide(toFrame: CGRect, delay: NSTimeInterval) {
        
        UIView.animateWithDuration(animationSettings.duration,
            delay: delay,
            usingSpringWithDamping: animationSettings.damping,
            initialSpringVelocity: animationSettings.velocity,
            options: ([.BeginFromCurrentState, .AllowUserInteraction]),
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

extension SFSwiftNotification: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        
        hide(self.toFrame, delay: self.delay)
    }
    
}
