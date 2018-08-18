//
//  PressStateAnimatable.swift
//  Awly
//
//  Created by v.a.prusakov on 18/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

protocol PressStateAnimatable: class {
    var pressStateAnimationMinScale: CGFloat { get }
    var pressStateAnimationDuration: TimeInterval { get }
    var isPressStateAnimationEnabled: Bool { get set }
}

extension PressStateAnimatable where Self: UIView {
    
    var pressStateAnimationMinScale: CGFloat { return 0.95 }
    var pressStateAnimationDuration: TimeInterval { return 0.1 }
    
    fileprivate var highlightRecognizer: TouchHandlerGestureRecognizer? {
        return self.gestureRecognizers?.first { $0 is TouchHandlerGestureRecognizer } as? TouchHandlerGestureRecognizer
    }
    
    var isPressStateAnimationEnabled: Bool {
        get { return self.highlightRecognizer != nil }
        set { newValue ? self.enablePressStateAnimation() : disablePressStateAnimation() }
    }
    
    fileprivate func enablePressStateAnimation() {
        
        let minScale = self.pressStateAnimationMinScale
        let duration = self.pressStateAnimationDuration
        
        guard minScale < 1, minScale >= 0, duration > 0 else { return }
        
        self.disablePressStateAnimation()
        
        let touchUpGesture = TouchHandlerGestureRecognizer { [weak self] (gesture) in
            if gesture.state == .began {
                self?.animatePressStateChange(pressed: true, minScale: minScale, duration: duration)
            }
            if gesture.state == .ended || gesture.state == .cancelled || gesture.state == .failed {
                self?.animatePressStateChange(pressed: false, minScale: minScale, duration: duration)
            }
        }
        touchUpGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(touchUpGesture)
    }
    
    fileprivate func animatePressStateChange(pressed: Bool, minScale: CGFloat, duration: TimeInterval) {
        let toValue = pressed ? CATransform3DMakeScale(minScale, minScale, 1) : CATransform3DMakeScale(1, 1, 1)
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        
        if let presentationLayer = layer.presentation() {
            scaleAnimation.fromValue = presentationLayer.transform
            
            // Percent of current animation
            let animationProgress = Double((presentationLayer.transform.m11 - minScale) / (1 - minScale))
            
            // If view doesn't touch, then animation reverse
            let durationMultiplier = pressed ? animationProgress : (1 - animationProgress)
            scaleAnimation.duration = duration * durationMultiplier
            
        } else {
            scaleAnimation.fromValue = layer.transform
            scaleAnimation.duration = duration
        }
        
        scaleAnimation.toValue = toValue
        scaleAnimation.duration = duration
        
        // Remove previous animation if it's in progress
        layer.removeAnimation(forKey: "scale")
        layer.add(scaleAnimation, forKey: "scale")
        layer.transform = toValue
    }
    
    fileprivate func disablePressStateAnimation() {
        if let recognizer = self.highlightRecognizer {
            self.removeGestureRecognizer(recognizer)
        }
    }
}

