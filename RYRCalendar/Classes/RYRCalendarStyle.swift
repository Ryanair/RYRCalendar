//
//  RYRCalendarStyle.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 07/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

public struct RYRCalendarStyle {
   
   // CollectionView properties
   public var monthHeaderHeight: Double = 30
   public var monthHeaderStyle = RYRMonthHeaderStyle(font: UIFont(name: "Arial", size: 16)!, textColor: UIColor(red:7.0/255.0, green:53.0/255.0, blue:147.0/255.0, alpha:1.0), backgroundColor: UIColor(red:246.0/255.0, green:248.0/255.0, blue:255.0/255.0, alpha:1.0))
   public var calendarHeaderStyle = RYRCalendarHeaderStyle(workDayFont: UIFont(name: "Arial", size: 16)!, workDayTextColor: UIColor(red:7.0/255.0, green:53.0/255.0, blue:147.0/255.0, alpha:1.0), weekendDayFont: UIFont(name: "Arial", size: 16)!, weekendDayTextColor: UIColor(red:7.0/255.0, green:53.0/255.0, blue:147.0/255.0, alpha:1.0), backgroundColor: UIColor(red:246.0/255.0, green:248.0/255.0, blue:255.0/255.0, alpha:1.0))
   
   // Cell styles
   public var cellStyleEnabled = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: nil, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.blackColor())
   public var cellStyleDisabled = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: nil, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.lightGrayColor())
   public var cellStyleToday = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage.loadImageInBundle("current_day_highlight"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.blackColor())
   public var cellStyleEmpty = RYREmptyCellStyle(backgroundColor: UIColor.whiteColor())
   
   // Single selection cell style
   public var cellStyleSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage.loadImageInBundle("one_way_highlight"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.whiteColor())
   public var cellStyleSelectedMultiple = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage.loadImageInBundle("same_day_highlight"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.whiteColor())
   
   // Multiple selection cell styles
   public var cellStyleFirstSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage.loadImageInBundle("closed_return_highlight_left"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.whiteColor())
   public var cellStyleLastSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage.loadImageInBundle("closed_return_highlight_right"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.whiteColor())
   public var cellStyleMiddleSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage.loadImageInBundle("highlight_travel_day"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Arial", size: 16)!, textColor: UIColor.blackColor())
}

extension UIImage {
   class func loadImageInBundle(named: String) -> UIImage? {
      let podBundle = NSBundle(forClass: RYRCalendar.classForCoder())
      if let bundleURL = podBundle.URLForResource("RYRCalendar", withExtension: "bundle"), bundle = NSBundle(URL: bundleURL) {
         return UIImage(named: named, inBundle: bundle, compatibleWithTraitCollection: nil)
      }
      return nil
   }
}
