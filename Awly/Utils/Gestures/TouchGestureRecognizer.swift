//
//  TouchGestureRecognizer.swift
//  Awly
//
//  Created by v.a.prusakov on 18/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

public class TouchGestureRecognizer: UIGestureRecognizer {
    
    init() {
        super.init(target: nil, action: nil)
    }
    
    override public func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        guard let view = view, let point = Array(touches).last?.location(in: view) else {
            return
        }
        
        if view.bounds.contains(point) {
            self.state = .possible
        } else {
            self.state = .ended
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        self.state = .ended
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        self.state = .cancelled
    }
}

