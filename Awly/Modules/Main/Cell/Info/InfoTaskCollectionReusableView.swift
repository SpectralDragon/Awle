//
//  InfoTaskCollectionReusableView.swift
//  Awly
//
//  Created by v.a.prusakov on 17/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

class InfoTaskCollectionReusableView: UICollectionReusableView, Reusable, Configurable {
    
    static let kind: String = "InfoTaskCollectionReusableView"
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var items: [InfoTaskDisplayItem] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(InfoTaskCollectionViewCell.nib, forCellWithReuseIdentifier: InfoTaskCollectionViewCell.reuseIdentifier)
    }
    
    func configure(with item: [InfoTaskDisplayItem]) {
        self.items = item
        self.collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension InfoTaskCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: InfoTaskCollectionViewCell.reuseIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? InfoTaskCollectionViewCell else { return }
        cell.configure(with: self.items[indexPath.row])
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension InfoTaskCollectionReusableView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let width = (collectionView.frame.width / 3) - collectionFlowLayout.minimumInteritemSpacing - (Style.Sizes.standartOffset * 2)
        let height = collectionView.frame.height - (collectionFlowLayout.minimumLineSpacing * 2)
        return CGSize(width: width, height: height)
    }
    
}
