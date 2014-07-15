//
//  LibHNUserToUser.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

extension User {
  init(user: HNUser) {
    self = User(username: user.Username, karma: Int(user.Karma), age: Int(user.Age), aboutInfo: user.AboutInfo)
  }
}
