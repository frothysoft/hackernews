//
//  HackerNewsAPI.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

protocol HackerNewsAPI {
  
  func logInWithUsername(username: String, password: String, completion: ((User!) -> Void)!)
  func loadPostsWithFilter(filter: PostFilterType, completion: (([Post]!) -> Void)!)
  func loadCommentsForPost(post: Post, completion: (([Comment]!) -> Void)!)
  func upvotePost(post: Post, completion: ((success: Bool) -> Void)!)
  func upvoteComment(comment: Comment, completion: ((success: Bool) -> Void)!)
  func replyToPost(post: Post, text: String, completion: ((success: Bool) -> Void)!)
  func replyToComment(comment: Comment, text: String, completion: ((success: Bool) -> Void)!)
  
}
