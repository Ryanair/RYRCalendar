//
//  RYREmptyDayCell.swift
//  RYRCalendar
//
//  Created by Miquel, Aram on 03/06/2016.
//  Copyright © 2016 Ryanair. All rights reserved.
//

import UIKit

class RYREmptyDayCell: UICollectionViewCell {
   class var cellIndentifier: String { get { return "RYRCalendarEmptyDayCellIndentifier" } }
   var style: RYREmptyCellStyle? { didSet { updateStyle(style!) } }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   private func setup() { }
   
   func updateStyle(newStyle: RYREmptyCellStyle) {
      backgroundColor = newStyle.backgroundColor
   }
}
