//
//  Collection+Extensions.swift
//  Awly
//
//  Created by v.a.prusakov on 17/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
