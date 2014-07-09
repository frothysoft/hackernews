//
//  UserDataAccess.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/8/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

protocol UserDataAccess {
  
  func storeUser(user: User, password: String)
  func deleteUser()
  func loggedInUser() -> User!

}
