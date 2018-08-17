//
//  MainViewController.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private weak var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setupSearchController()
    }
    
    // MARK: - Setup
    
    private func registerCells() {
        self.collectionView.register(TaskCollectionViewCell.nib, forCellWithReuseIdentifier: TaskCollectionViewCell.reuseIdentifier)
        self.collectionView.register(TaskSectionHeaderView.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TaskSectionHeaderView.reuseIdentifier)
        self.collectionView.register(InfoTaskCollectionReusableView.nib, forSupplementaryViewOfKind: InfoTaskCollectionReusableView.kind, withReuseIdentifier: InfoTaskCollectionReusableView.reuseIdentifier)
    }
    
    private func setupSearchController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController = searchController
    }
    
    // MARK: - Actions
    
    @IBAction func onAddItemAction(_ sender: UIBarButtonItem) {
        
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
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
        let reuseIdentifier = InfoTaskCollectionReusableView.kind == kind ? InfoTaskCollectionReusableView.reuseIdentifier : TaskSectionHeaderView.reuseIdentifier
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? TaskCollectionViewCell else { return }
        cell.titleLabel.text = "Надо выполнить"
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        switch elementKind {
        case InfoTaskCollectionReusableView.kind:
            guard let view = view as? InfoTaskCollectionReusableView else { return }
            view.configure(with: [InfoTaskDisplayItem(title: "Completed", count: 123), InfoTaskDisplayItem(title: "Doing", count: 123), InfoTaskDisplayItem(title: "Completed", count: 123)])
        case UICollectionElementKindSectionHeader:
            guard let view = view as? TaskSectionHeaderView else { return }
            view.titleLabel.text = "Today"
        default:
            return
        }
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16 * 2, height: 45)
    }
    
}

// MARK: - UICollectionViewDataSourcePrefetching

extension MainViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
}
