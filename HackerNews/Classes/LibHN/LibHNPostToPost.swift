//
//  LibHNPostToPost.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

extension Post {
  static func postFromHNPost(post: HNPost) -> Post {
    return Post(postId: post.PostId, title: post.Title, username: post.Username, points: Int(post.Points), commentCount: Int(post.CommentCount), timeCreatedString: post.TimeCreatedString, type: post.Type)
  }
}
