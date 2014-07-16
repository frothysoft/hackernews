//
//  Colors.swift
//  FindMyPet
//
//  Created by Josh Berlin on 6/23/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import Foundation

extension UIColor {
  
  convenience init(rgbValue: UInt) {
    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  
  class func lightGreyTextColor() -> UIColor { return UIColor(rgbValue: 0xA8B5C1) }
  class func activeTextColor() -> UIColor { return UIColor(rgbValue: 0x3354D5) }
  class func linkColor() -> UIColor { return UIColor(rgbValue: 0x0061E3) }
  
}