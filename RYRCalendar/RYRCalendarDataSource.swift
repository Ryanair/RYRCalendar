//
//  RYRCalendarDataSource.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 14/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

class RYRCalendarDataSource: NSObject, UICollectionViewDataSource {
   var baseDate: NSDate
   var style: RYRCalendarStyle
   var singleSelectionIndexPath: NSIndexPath?
   var multipleSelectionIndexPaths = [NSIndexPath]()
   
   init(baseDate: NSDate, style: RYRCalendarStyle) {
      self.baseDate = baseDate
      self.style = style
      
      super.init()
   }
   
   private func getBlankSpaces(fromDate: NSDate?) -> Int {
      if let firstDayOfMonth = fromDate?.setToFirstDayOfMonth() {
         
         let components = NSCalendar.currentCalendar().components([.Weekday], fromDate: firstDayOfMonth)
         
         let firstDayIndex = components.weekday - 2 //TODO: @Aram why this - 2 is necessary?
         
         return firstDayIndex
      }
      
      return 0
   }
   
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let dateForSection = baseDate.dateByAddingMonths(section)
      var numberOfItems = dateForSection?.numberOfDaysInCurrentMonth() ?? 0
      numberOfItems += getBlankSpaces(dateForSection) ?? 0
      
      return numberOfItems
   }
   
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let dateForSection = baseDate.dateByAddingMonths(indexPath.section)?.setToFirstDayOfMonth()
      let blankSpaces = getBlankSpaces(dateForSection)
      
      if indexPath.row >= blankSpaces {
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier(RYRDayCell.cellIndentifier, forIndexPath: indexPath) as! RYRDayCell
         cell.dayNumber = indexPath.row - blankSpaces + 1
         
         if let rowDate = dateForSection?.dateByAddingDays(indexPath.row - blankSpaces) {
            if rowDate.isPastDay() {
               cell.style = style.cellStyleDisabled
            } else if indexPath == singleSelectionIndexPath {
               cell.style = style.cellStyleSelected
            } else if multipleSelectionIndexPaths.contains(indexPath) {
               if multipleSelectionIndexPaths.count > 1 && multipleSelectionIndexPaths.first == multipleSelectionIndexPaths.last {
                  cell.style = style.cellStyleSelectedMultiple
               } else if multipleSelectionIndexPaths.first == indexPath {
                  cell.style = style.cellStyleFirstSelected
               } else if multipleSelectionIndexPaths.last == indexPath {
                  cell.style = style.cellStyleLastSelected
               }
            } else if rowDate.isBetweenDates(dateFromIndexPath(multipleSelectionIndexPaths.first), secondDate: dateFromIndexPath(multipleSelectionIndexPaths.last)) {
               cell.style = style.cellStyleMiddleSelected
            }else if rowDate.isToday() {
               cell.style = style.cellStyleToday
            } else if delegate?.isDateAvailableToSelect(rowDate) ?? true {
               cell.style = style.cellStyleEnabled
            } else {
               cell.style = style.cellStyleDisabled
            }
         }
         return cell
      } else {
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier(RYREmptyDayCell.cellIndentifier, forIndexPath: indexPath) as! RYREmptyDayCell
         
         return cell
      }
   }
   
   func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      return totalMonthsFromNow
   }
   
}
