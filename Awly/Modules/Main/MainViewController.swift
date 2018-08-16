//
//  MainViewController.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(TaskCollectionViewCell.nib, forCellWithReuseIdentifier: TaskCollectionViewCell.reuseIdentifier)
        self.collectionView.register(TaskSectionHeaderView.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TaskSectionHeaderView.reuseIdentifier)
    }
    
    // MARK: - Actions
    
    @IBAction func onAddItemAction(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.reuseIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TaskSectionHeaderView.reuseIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? TaskCollectionViewCell else { return }
        cell.titleLabel.text = "Надо выполнить"
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard let view = view as? TaskSectionHeaderView else { return }
        view.titleLabel.text = "Today"
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16 * 2, height: 45)
    }
    
    
    // MARK: - UICollectionViewDataSourcePrefetching
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
}
