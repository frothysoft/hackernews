//
//  Comment.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/14/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

struct Comment {
  
  let commentId: String
  let username: String
  let text: String
  let timeCreatedString: String
  let replyURLString: String?
  let level: Int
  let upvoteURLAddition: String?
  
}
