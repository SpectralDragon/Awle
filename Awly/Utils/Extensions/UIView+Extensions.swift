//
//  UIView+Extensions.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadow(color: UIColor? = nil, blurRadius: CGFloat = 20, opacity: Float = 0.3, offset: CGSize = CGSize(width: 0, height: 5), shouldRasterize: Bool = true) {
        self.layer.shadowColor = color?.cgColor ?? self.backgroundColor?.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = blurRadius
        self.layer.shadowOffset = offset
        /* Experimenntal solution to increase performance */
        if shouldRasterize {
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
}
