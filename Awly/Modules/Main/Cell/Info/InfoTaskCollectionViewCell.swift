//
//  InfoTaskCollectionViewCell.swift
//  Awly
//
//  Created by v.a.prusakov on 17/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

class InfoTaskCollectionViewCell: UICollectionViewCell, Reusable, Configurable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.applyShadow()
    }
    
    func configure(with item: InfoTaskDisplayItem) {
        titleLabel.text = "\(item.count)"
        subtitleLabel.text = item.title
    }

}
