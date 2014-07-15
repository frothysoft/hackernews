//
//  PostTypeImages.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

extension Post {
  func typeImage() -> UIImage! {
    if self.type == PostType.AskHN {
      return UIImage(named: "badge-ask")
    } else if self.type == PostType.Jobs {
      return UIImage(named: "badge-job")
    } else if self.title.bridgeToObjectiveC().containsString("Show HN: ") {
      return UIImage(named: "badge-show")
    } else {
      return nil
    }
  }
}
