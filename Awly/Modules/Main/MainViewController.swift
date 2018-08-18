//
//  MainViewController.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    enum Constants {
        static let tastViewerSegueIdentifier = "tastViewerSegue"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private weak var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setupCollectionViewLayout()
        self.setupSearchController()
    }
    
    // MARK: - Setup
    
    private func registerCells() {
        self.collectionView.register(TaskCollectionViewCell.nib, forCellWithReuseIdentifier: TaskCollectionViewCell.reuseIdentifier)
        self.collectionView.register(TaskSectionHeaderView.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TaskSectionHeaderView.reuseIdentifier)
    }
    
    private func setupCollectionViewLayout() {
        let collectionLayout = TaskCollectionLayout()
        collectionLayout.delegate = self
        self.collectionView.collectionViewLayout = collectionLayout
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.tastViewerSegueIdentifier else { return }
        
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
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
        case UICollectionElementKindSectionHeader:
            guard let view = view as? TaskSectionHeaderView else { return }
            view.titleLabel.text = "Today \(indexPath.section)"
        default:
            return
        }
    }
    
}

// MARK: - UICollectionViewDataSourcePrefetching

extension MainViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
}

// MARK: - TaskCollectionLayoutDelegate

extension MainViewController: TaskCollectionLayoutDelegate {
    
    func itemHeight(at indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 50
    }
    
    func heightForSupplementaryViewOfKind(_ kind: String) -> CGFloat? {
        return kind == UICollectionElementKindSectionHeader ? 50 : nil
    }
    
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

// MARK: - UISearchControllerDelegate

extension MainViewController: UISearchControllerDelegate {
    
}
