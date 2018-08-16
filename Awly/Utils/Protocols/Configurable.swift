//
//  Configurable.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import Foundation

protocol Configurable {
    associatedtype Configuration
    func configure(with item: Configuration)
}
