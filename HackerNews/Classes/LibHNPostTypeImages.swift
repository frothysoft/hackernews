//
//  LibHNPostTypeImages.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

extension HNPost {
  func typeImage() -> UIImage! {
    var type = self.valueForKey("Type").integerValue
    if type == 1 {
      return UIImage(named: "badge-ask")
    } else if type == 2 {
      return UIImage(named: "badge-job")
    } else if self.Title.bridgeToObjectiveC().containsString("Show HN: ") {
      return UIImage(named: "badge-show")
    } else {
      return nil
    }
  }
}
