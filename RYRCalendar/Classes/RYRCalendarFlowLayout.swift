//
//  RYRCalendarFlowLayout.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 03/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

class RYRCalendarFlowLayout: UICollectionViewFlowLayout {
   
   override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      
      guard var superAttributes = super.layoutAttributesForElementsInRect(rect) else {
         return super.layoutAttributesForElementsInRect(rect)
      }
      
      let contentOffset = collectionView!.contentOffset
      let missingSections = NSMutableIndexSet()
      
      for layoutAttributes in superAttributes where (layoutAttributes.representedElementCategory == .Cell && layoutAttributes.representedElementKind != UICollectionElementKindSectionHeader) {
         missingSections.addIndex(layoutAttributes.indexPath.section)
      }
      
      missingSections.enumerateIndexesUsingBlock { idx, stop in
         let indexPath = NSIndexPath(forItem: 0, inSection: idx)
         if let layoutAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath) {
            superAttributes.append(layoutAttributes)
         }
      }
      
      for layoutAttributes: UICollectionViewLayoutAttributes in superAttributes {
         
         if let representedElementKind = layoutAttributes.representedElementKind where representedElementKind == UICollectionElementKindSectionHeader {
            let section = layoutAttributes.indexPath.section
            let numberOfItemsInSection = collectionView!.numberOfItemsInSection(section)
            
            if numberOfItemsInSection > 0 {
               let firstCellIndexPath = NSIndexPath(forItem: 0, inSection: section)
               let lastCellIndexPath = NSIndexPath(forItem: max(0, (numberOfItemsInSection - 1)), inSection: section)
               
               var firstCellAttributes:UICollectionViewLayoutAttributes
               var lastCellAttributes:UICollectionViewLayoutAttributes
               
               firstCellAttributes = self.layoutAttributesForItemAtIndexPath(firstCellIndexPath)!
               lastCellAttributes = self.layoutAttributesForItemAtIndexPath(lastCellIndexPath)!
               
               let headerHeight = CGRectGetHeight(layoutAttributes.frame)
               var origin = layoutAttributes.frame.origin
               
               origin.y = min(max(contentOffset.y, (CGRectGetMinY(firstCellAttributes.frame) - headerHeight)), (CGRectGetMaxY(lastCellAttributes.frame) - headerHeight));
               
               layoutAttributes.zIndex = 1024;
               layoutAttributes.frame = CGRect(origin: origin, size: layoutAttributes.frame.size)
            }
         }
      }
      
      return NSArray(array: superAttributes) as? [UICollectionViewLayoutAttributes]
   }
   
   override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
      return true
   }
}
