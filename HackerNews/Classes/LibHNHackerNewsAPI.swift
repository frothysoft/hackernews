//
//  LibHNHackerNewsAPI.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class LibHNHackerNewsAPI: HackerNewsAPI {
  
  func logInWithUsername(username: String, password: String, completion: ((User!) -> Void)!) {
    HNManager.sharedManager().loginWithUsername(username, password: password) { (hnUser: HNUser!) in
      var user: User! = nil
      if hnUser {
        user = User(user: hnUser)
      }
      if completion { completion(user) }
    }
  }
  
  func loadPostsWithFilter(filter: PostFilterType, completion: (([Post]!) -> Void)!) {
    HNManager.sharedManager().loadPostsWithFilter(PostFilterType.Top) { (hnPosts: [AnyObject]!) in
      var posts: [Post] = []
      for hnPost in hnPosts as [HNPost] {
        var post = Post.postFromHNPost(hnPost)
        posts += post
      }
      if completion { completion(posts) }
    }
  }
  
}
