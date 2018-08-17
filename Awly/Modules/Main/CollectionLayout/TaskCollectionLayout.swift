//
//  TaskCollectionLayout.swift
//  Awly
//
//  Created by v.a.prusakov on 16/08/2018.
//  Copyright © 2018 v.a.prusakov. All rights reserved.
//

import UIKit

protocol TaskCollectionLayoutDelegate: class {
    func itemHeight(at indexPath: IndexPath, with width: CGFloat) -> CGFloat
    func heightForSupplementaryViewOfKind(_ kind: String) -> CGFloat?
    func supplementaryViewKind(forSection section: Int) -> String?
}

class TaskCollectionLayout: UICollectionViewFlowLayout {
    
    /// By default is equal 300, because on iPhone cell fill all screnn, and on iPad two or more (iPad Pro)
    var prefferedMinimumCellWidth: CGFloat = 300
    
    weak var delegate: TaskCollectionLayoutDelegate!
    private var cachedAttributes: [Int : [UICollectionViewLayoutAttributes]] = [:]
    private var deletedIndexPaths: [IndexPath] = []
    private var contentSize: CGSize = .zero
    
    override var collectionViewContentSize: CGSize {
        if self.contentSize == .zero, let collectionView = self.collectionView, collectionView.numberOfItems(inSection: 0) > 0 {
            self.prepare()
        }
        return self.contentSize
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else { return }
        let sections = collectionView.numberOfSections
        for section in 0 ..< sections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            self.cachedAttributes[section] = []
            
            let availableWidth = collectionView.bounds.width - Style.Sizes.standartOffset
            let maxNumColumn = Int(availableWidth / self.prefferedMinimumCellWidth)
            let itemWidth = (availableWidth / CGFloat(maxNumColumn)).rounded(.down) - Style.Sizes.standartOffset
            
            var columnYOffset = Array(repeating: self.sectionInset.top, count: maxNumColumn)
            
            for index in 0 ..< numberOfItems {
                let indexPath = IndexPath(row: index, section: 0)
                let itemHeight = self.delegate.itemHeight(at: indexPath, with: itemWidth)
                
                let minY: CGFloat = columnYOffset.min()!
                let column = columnYOffset.index(of: minY)!
                let x = CGFloat(column) * (itemWidth + Style.Sizes.standartOffset) + Style.Sizes.standartOffset
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: x, y: minY, width: itemWidth, height: itemHeight)
                self.cachedAttributes[section]?.append(attributes)
                
                columnYOffset[column] = minY + itemHeight + Style.Sizes.standartOffset
            }
            
            if let footerHeight = self.delegate.heightForSupplementaryViewOfKind(UICollectionElementKindSectionFooter) {
                let indexPath = IndexPath(row: numberOfItems, section: 0)
                let columnMaxYOffset = columnYOffset.max() ?? 0
                let footerAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: indexPath)
                footerAttributes.frame = CGRect(x: 0, y: columnMaxYOffset, width: collectionView.bounds.width, height: footerHeight)
                self.cachedAttributes[section]?.append(footerAttributes)
                self.contentSize = CGSize(width: collectionView.bounds.width, height: columnYOffset.max()! + footerHeight)
            } else if let headerHeight = self.delegate.heightForSupplementaryViewOfKind(UICollectionElementKindSectionFooter) {
                
            } else if let kind = self.delegate.supplementaryViewKind(forSection: section), let height = self.delegate.heightForSupplementaryViewOfKind(kind) {
                
            } else {
                self.contentSize = CGSize(width: collectionView.bounds.width, height: columnYOffset.max()!)
            }
        }
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        self.deletedIndexPaths.removeAll()
        
        self.deletedIndexPaths.append(contentsOf: updateItems.filter { $0.updateAction == .delete }.compactMap { $0.indexPathBeforeUpdate })
        super.prepare(forCollectionViewUpdates: updateItems)
    }
    
    override func finalizeCollectionViewUpdates() {
        self.deletedIndexPaths.removeAll()
        super.finalizeCollectionViewUpdates()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds.size != self.collectionViewContentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let aa = self.cachedAttributes.map { $0.value.filter { $0.frame.intersects(rect) } }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cachedAttributes[indexPath.section]?[safe: indexPath.row]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cachedAttributes[indexPath.section]?[safe: indexPath.row]
    }
    
    override func indexPathsToDeleteForSupplementaryView(ofKind elementKind: String) -> [IndexPath] {
        return self.deletedIndexPaths
    }
    
}
