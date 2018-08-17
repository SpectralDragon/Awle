//
//  Reusable.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

protocol OrderedCollectionReusableView {}
protocol Cell: OrderedCollectionReusableView {}

typealias ReusableTableViewCell = UITableViewCell & Reusable
typealias ReusableCollectionViewCell = UICollectionViewCell & Reusable
typealias ReusableTableViewHeaderFooter = UITableViewHeaderFooterView & Reusable

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension Reusable where Self: OrderedCollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self) + "Identifier"
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        let nib = UINib(nibName: self.nibName, bundle: Bundle.main)
        return nib
    }
}

extension UITableViewCell: Cell {}
extension UITableViewHeaderFooterView: OrderedCollectionReusableView {}
extension UICollectionReusableView: OrderedCollectionReusableView {}
