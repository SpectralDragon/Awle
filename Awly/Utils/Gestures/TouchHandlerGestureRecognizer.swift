//
//  TouchHandlerGestureRecognizer.swift
//  Awly
//
//  Created by v.a.prusakov on 18/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

final class TouchHandlerGestureRecognizer: TouchGestureRecognizer {
    
    typealias StateChangeHandler = ((UIGestureRecognizer) -> Void)
    
    private let stateChangeHandler: StateChangeHandler
    
    public required init(stateChangeHandler: @escaping StateChangeHandler) {
        self.stateChangeHandler = stateChangeHandler
        super.init()
        self.addTarget(self, action: #selector(handleStateChange(_:)))
    }
    
    // MARK: - Handler
    
    @objc private func handleStateChange(_ gestureRecognizer: UIGestureRecognizer) {
        self.stateChangeHandler(gestureRecognizer)
    }
}
