//
//  TaskCollectionViewCell.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell, Reusable, PressStateAnimatable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyShadow()
        self.isPressStateAnimationEnabled = true
    }

}
