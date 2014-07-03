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
  func loadPostsWithFilter(filter: PostFilterType, completion: ((Post[]!) -> Void)!)
  
}
