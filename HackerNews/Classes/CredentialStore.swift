//
//  CredentialStore.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/9/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

protocol CredentialStore {
  
  func storeCredentials(username: String, password: String)
  func credentials() -> (username: String, password: String)!
  func removeCredentials()
  
}
