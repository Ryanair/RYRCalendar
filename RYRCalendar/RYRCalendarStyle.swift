//
//  RYRCalendarStyle.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 07/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

struct RYRCalendarStyle {
   
   // CollectionView properties
   var monthHeaderHeight: Double = 30
   var monthHeaderStyle = RYRMonthHeaderStyle(font: UIFont(name: "Roboto-Bold", size: 16)!, textColor: UIColor(red:7.0/255.0, green:53.0/255.0, blue:147.0/255.0, alpha:1.0), backgroundColor: UIColor(red:246.0/255.0, green:248.0/255.0, blue:255.0/255.0, alpha:1.0))
   var calendarHeaderStyle = RYRCalendarHeaderStyle(workDayFont: UIFont(name: "Roboto-Regular", size: 16)!, workDayTextColor: UIColor(red:7.0/255.0, green:53.0/255.0, blue:147.0/255.0, alpha:1.0), weekendDayFont: UIFont(name: "Roboto-Bold", size: 16)!, weekendDayTextColor: UIColor(red:7.0/255.0, green:53.0/255.0, blue:147.0/255.0, alpha:1.0), backgroundColor: UIColor(red:246.0/255.0, green:248.0/255.0, blue:255.0/255.0, alpha:1.0))
   
   // Cell styles
   var cellStyleEnabled = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: nil, textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.blackColor())
   var cellStyleDisabled = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: nil, textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.lightGrayColor())
   var cellStyleToday = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage(named: "current_day_highlight"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.blackColor())
   var cellStyleEmpty = RYREmptyCellStyle(backgroundColor: UIColor.whiteColor())
   
   // Single selection cell style
   var cellStyleSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage(named: "one_way_highlight"), textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.whiteColor())
   var cellStyleSelectedMultiple = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage(named: "same_day_highlight"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.whiteColor())
   
   // Multiple selection cell styles
   var cellStyleFirstSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage(named: "closed_return_highlight_left"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.whiteColor())
   var cellStyleLastSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage(named: "closed_return_highlight_right"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.whiteColor())
   var cellStyleMiddleSelected = RYRDayCellStyle(backgroundColor: UIColor.whiteColor(), backgroundImage: UIImage(named: "highlight_travel_day"), backgroundImageContentMode: .ScaleToFill, textFont: UIFont(name: "Roboto-Regular", size: 16)!, textColor: UIColor.blackColor())
}