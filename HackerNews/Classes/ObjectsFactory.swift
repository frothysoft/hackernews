//
//  ObjectsFactory.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

protocol ObjectsFactory {
  
  var hackerNewsAPI: HackerNewsAPI { get }
  var userDataAccess: UserDataAccess { get }

}

class HackerNewsObjectFactory: ObjectsFactory {
  
  let hackerNewsAPI: HackerNewsAPI
  let userDataAccess: UserDataAccess
  let credentialStore: CredentialStore
  
  init() {
    hackerNewsAPI = LibHNHackerNewsAPI()
    credentialStore = AccountCredentialStore()
    userDataAccess = LibHNUserStore(credentialStore: credentialStore, hackerNewsAPI: hackerNewsAPI)
  }
  
}
