//
//  RYRCalendar.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 01/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

protocol RYRCalendarDelegate: class {
   func calendarDidSelectDate(calendar: RYRCalendar, selectedDate: NSDate)
   func calendarDidSelectMultipleDate(calendar: RYRCalendar, selectedStartDate startDate: NSDate, endDate: NSDate)
   func isDateAvailableToSelect(date: NSDate) -> Bool
   func calendarDidScrollToMonth(calendar: RYRCalendar, monthDate: NSDate)
}

extension RYRCalendarDelegate {
   func isDateAvailableToSelect(date: NSDate) -> Bool {
      return true
   }
}

enum RYRCalendarSelectionType: Int {
   case None, Single, Multiple
}

class RYRCalendar: UIView {
   
   // PUBLIC (API)
   var style: RYRCalendarStyle = RYRCalendarStyle()
   
   weak var delegate: RYRCalendarDelegate?
   var selectionType: RYRCalendarSelectionType = .None
   var totalMonthsFromNow: Int = 1
   
   // Date configuration
   var baseDate: NSDate = NSDate()
   
   // PRIVATE
   private var singleSelectionIndexPath: NSIndexPath?
   private var multipleSelectionIndexPaths = [NSIndexPath]()
   
   private var headerView: RYRCalendarHeaderView!
   private var collectionView: UICollectionView!
   private var collectionViewLayout: UICollectionViewFlowLayout!
   
   private var cellSize: CGFloat {
      get {
         return CGFloat(Int(frame.size.width / 7))
      }
   }
   
   // MARK: Initializers
   init() {
      super.init(frame: CGRectZero)
      setup()
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   override func didMoveToSuperview() {
      self.collectionView.frame = superview!.frame
   }
   
   // MARK: Public
   func update() {
      self.collectionView.reloadData()
   }
   
   // MARK: Private
   private func setup() {
      
      headerView = RYRCalendarHeaderView()
      headerView.style = style.calendarHeaderStyle
      addSubview(headerView)
      
      
      if #available(iOS 9.0, *) {
         collectionViewLayout = UICollectionViewFlowLayout()
         collectionViewLayout.sectionHeadersPinToVisibleBounds = true
      } else {
         collectionViewLayout = RYRCalendarFlowLayout()
      }
      
      collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
      collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
      addSubview(collectionView)
      
      headerView.translatesAutoresizingMaskIntoConstraints = false
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: ["collectionView": collectionView]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[headerView]-0-|", options: [], metrics: nil, views: ["headerView": headerView]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[headerView(30)][collectionView]-0-|", options: [], metrics: nil, views: ["collectionView": collectionView, "headerView": headerView]))
      
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.backgroundColor = UIColor.clearColor()
      collectionView.registerClass(RYRDayCell.self, forCellWithReuseIdentifier: RYRDayCell.cellIndentifier)
      collectionView.registerClass(RYREmptyDayCell.self, forCellWithReuseIdentifier: RYREmptyDayCell.cellIndentifier)
      collectionView.registerClass(RYRMonthHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: RYRMonthHeaderReusableView.identifier)
      
      update()
   }
   
   private func getBlankSpaces(fromDate: NSDate?) -> Int {
      if let firstDayOfMonth = fromDate?.firstDayOfMonth() {
         
         let components = NSCalendar.currentCalendar().components([.Weekday], fromDate: firstDayOfMonth)
         
         let firstDayIndex = components.weekday - 2 //TODO: @Aram why this - 2 is necessary?
         
         return firstDayIndex
      }
      
      return 0
   }
   
   private func selectSingleIndexPath(indexPath: NSIndexPath) {
      
      if let previousSelectedIndexPath = singleSelectionIndexPath {
         unselectIndexPath(previousSelectedIndexPath)
      }
      
      if let date = dateFromIndexPath(indexPath) {
         if delegate?.isDateAvailableToSelect(date) ?? false {
            
            singleSelectionIndexPath = indexPath
            collectionView.reloadItemsAtIndexPaths([indexPath])
            
            delegate?.calendarDidSelectDate(self, selectedDate: date)
         }
      }
   }
   
   private func selectMultipleIndexPath(indexPath: NSIndexPath) {
      guard let newDateSelection = dateFromIndexPath(indexPath) else { print("Error converting indexPath from selected date"); return }
      
      if let firstSelectedIndex = multipleSelectionIndexPaths.first, let firstDateSelection = dateFromIndexPath(firstSelectedIndex) {
         
         if multipleSelectionIndexPaths.count > 1 {
            // Contains two previously selected dates
            
            // We empty the selection, and select the newDate
            multipleSelectionIndexPaths = []
            multipleSelectionIndexPaths.append(indexPath)
            
            if let date = dateFromIndexPath(indexPath) {
               delegate?.calendarDidSelectDate(self, selectedDate: date)
            }
         } else {
            
            // Contains one previously selected date
            let order = firstDateSelection.compare(newDateSelection)
            switch order {
            case .OrderedAscending:
               // If the firstDateSelection is before the newDateSelection, newDateSelection will become the second selected date
               multipleSelectionIndexPaths.append(indexPath)
            case .OrderedDescending:
               // If the firstDateSelection is after the newDateSelection, multipleSelectionIndexPaths will be emptied and then newDateSelection added
               multipleSelectionIndexPaths = []
               multipleSelectionIndexPaths.append(indexPath)
               
               if let date = dateFromIndexPath(indexPath) {
                  delegate?.calendarDidSelectDate(self, selectedDate: date)
               }
               
            case .OrderedSame:
               // If the firstDateSelection is same as newDateSelection, multipleSelectionIndexPaths will be emptied
               multipleSelectionIndexPaths.append(indexPath)
            }
            
            if multipleSelectionIndexPaths.count > 1 {
               if let startDate = dateFromIndexPath(multipleSelectionIndexPaths.first), endDate = dateFromIndexPath(multipleSelectionIndexPaths.last) {
                  delegate?.calendarDidSelectMultipleDate(self, selectedStartDate: startDate, endDate: endDate)
               }
            }
         }
      } else {
         // Does not contain any date
         multipleSelectionIndexPaths.append(indexPath)
         
         if let date = dateFromIndexPath(indexPath) {
            delegate?.calendarDidSelectDate(self, selectedDate: date)
         }
      }
      
      collectionView.reloadItemsAtIndexPaths(collectionView.indexPathsForVisibleItems())
   }
   
   private func unselectIndexPath(indexPath: NSIndexPath) {
      singleSelectionIndexPath = nil
      collectionView.reloadItemsAtIndexPaths([indexPath])
   }
   
   private func dateFromIndexPath(indexPath: NSIndexPath?) -> NSDate? {
      guard let indexPath = indexPath else { return nil }
      
      let monthDate = baseDate.datePlusMonths(indexPath.section)?.firstDayOfMonth()
      let blankSpaces = getBlankSpaces(monthDate)
      return monthDate?.datePlusDays(indexPath.row - blankSpaces)
   }
}

// MARK: CollectionView DataSource
extension RYRCalendar: UICollectionViewDataSource {
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let dateForSection = baseDate.datePlusMonths(section)
      var numberOfItems = dateForSection?.daysInMonth() ?? 0
      numberOfItems += getBlankSpaces(dateForSection) ?? 0
      
      return numberOfItems
   }
   
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let dateForSection = baseDate.datePlusMonths(indexPath.section)?.firstDayOfMonth()
      let blankSpaces = getBlankSpaces(dateForSection)
      
      if indexPath.row >= blankSpaces {
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier(RYRDayCell.cellIndentifier, forIndexPath: indexPath) as! RYRDayCell
         cell.dayNumber = indexPath.row - blankSpaces + 1

         if let rowDate = dateForSection?.datePlusDays(indexPath.row - blankSpaces) {
            if rowDate.isPastDay(baseDate) {
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
            }else if rowDate.isToday(baseDate) {
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

// MARK: CollectionView Delegate
extension RYRCalendar: UICollectionViewDelegate {
   func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
      
      switch selectionType {
      case .None:
         return
      case .Single:
         selectSingleIndexPath(indexPath)
      case .Multiple:
         selectMultipleIndexPath(indexPath)
      }
   }
   
   func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
      if let view = view as? RYRMonthHeaderReusableView {
         delegate?.calendarDidScrollToMonth(self, monthDate: view.date!)
      }
   }
}

// MARK: FlowLayout Delegate
extension RYRCalendar: UICollectionViewDelegateFlowLayout {
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      return CGSizeMake(cellSize, cellSize)
   }
   
   func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
      if kind == UICollectionElementKindSectionHeader {
         let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: RYRMonthHeaderReusableView.identifier, forIndexPath: indexPath) as! RYRMonthHeaderReusableView
         view.date = baseDate.firstDayOfMonth()!.datePlusMonths(indexPath.section)
         view.style = style.monthHeaderStyle
         return view
      }
      
      return UICollectionReusableView()
   }
   
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      return CGSizeMake(collectionView.frame.width, CGFloat(style.monthHeaderHeight))
   }
   
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
      return 0
   }
   
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
      return 0
   }
   
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
      let lateralSpacing = (frame.width - (cellSize * 7)) / 2
      return UIEdgeInsets(top: 0, left: lateralSpacing, bottom: 0, right: lateralSpacing)
   }
   
}

// MARK: Extension NSDate
private extension NSDate {
   func daysInMonth() -> Int {
      return NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
   }
   
   func datePlusMonths(monthsToAdd: Int) -> NSDate? {
      let calendar = NSCalendar.currentCalendar()
      
      if #available(iOS 8.0, *) {
         return calendar.dateByAddingUnit(.Month, value: monthsToAdd, toDate: self, options: [])
      } else {
         let components = NSDateComponents()
         components.month = monthsToAdd
         return calendar.dateByAddingComponents(components, toDate: self, options: [])
      }
   }
   
   func firstDayOfMonth() -> NSDate? {
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: self)
      return calendar.dateFromComponents(components)
   }
   
   func datePlusDays(daysToAdd: Int) -> NSDate? {
      if #available(iOS 8.0, *) {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: daysToAdd, toDate: self, options: [])
      } else {
         let components = NSDateComponents()
         components.day = daysToAdd
         return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: [])
      }
   }
   
   func isPastDay(baseDate: NSDate) -> Bool {
      let calendar = NSCalendar.currentCalendar()
      let components = calendar.components([.Year, .Day, .Month], fromDate: NSDate())
      return compare(calendar.dateFromComponents(components)!) == .OrderedAscending
   }
   
   func isToday(baseDate: NSDate) -> Bool {
      if #available(iOS 8.0, *) {
         return  NSCalendar.currentCalendar().isDateInToday(self)
      } else {
         let calendar = NSCalendar.currentCalendar()
         let todayComponents = calendar.components([.Year, .Month, .Day], fromDate: NSDate())
         let selfComponents = calendar.components([.Year, .Month, .Day], fromDate: self)
         
         return calendar.dateFromComponents(todayComponents)!.isEqualToDate(calendar.dateFromComponents(selfComponents)!)
      }
   }
   
   func isBetweenDates(firstDate: NSDate?, secondDate: NSDate?) -> Bool {
      guard let firstDate = firstDate, secondDate = secondDate else { return false }
      
      return firstDate.compare(self) == self.compare(secondDate)
   }
}