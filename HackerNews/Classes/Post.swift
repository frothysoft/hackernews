//
//  Post.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

struct Post {
  
  let postId: String
  let title: String
  let username: String
  let points: Int
  let commentCount: Int
  let timeCreatedString: String
  // TODO: Create our own post type enum
  let type: PostType
  
}
