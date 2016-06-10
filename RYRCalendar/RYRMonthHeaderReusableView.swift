//
//  RYRCalendarHeaderReusableView.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 02/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

class RYRMonthHeaderReusableView: UICollectionReusableView {
   
   class var identifier: String { get { return "RYRCalendarHeaderReusableViewIndentifier" } }
   
   var date: NSDate? { didSet { updateDate(date!) } }
   var style: RYRMonthHeaderStyle? { didSet { updateStyle(style!) } }
   
   private var dateLabel: UILabel!
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   private func setup() {
      backgroundColor = UIColor.yellowColor()
      
      dateLabel = UILabel(frame: CGRectZero)
      addSubview(dateLabel)
      
      dateLabel.translatesAutoresizingMaskIntoConstraints = false
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-12-[dateLabel]-0-|", options: [], metrics: nil, views: ["dateLabel": dateLabel]))
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[dateLabel]-0-|", options: [], metrics: nil, views: ["dateLabel": dateLabel]))
   }
   
   private func updateDate(date: NSDate) {
      dateLabel.text = "\(date.month) \(date.year)"
   }
   
   private func updateStyle(style: RYRMonthHeaderStyle) {
      backgroundColor = style.backgroundColor
      dateLabel.font = style.font
      dateLabel.textColor = style.textColor
   }
}


private extension NSDate {
   var month: String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "MMM"
      return dateFormatter.stringFromDate(self)
   }
   
   var year: String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "yyyy"
      return dateFormatter.stringFromDate(self)
   }
}