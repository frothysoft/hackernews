//
//  LibHNUserStore.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/8/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class LibHNUserStore: UserDataAccess {
  
  let hnManager = HNManager.sharedManager()
  var credentialStore: CredentialStore
  let hackerNewsAPI: HackerNewsAPI
  
  init(credentialStore: CredentialStore, hackerNewsAPI: HackerNewsAPI) {
    self.credentialStore = credentialStore
    self.hackerNewsAPI = hackerNewsAPI
  }
  
  func storeUser(user: User, password: String) {
    credentialStore.storeCredentials(user.username, password: password)
  }
  
  func deleteUser() {
    hnManager.logout()
    credentialStore.removeCredentials()
  }
  
  func loggedInUser(completion: ((user: User!) -> Void)!) {
    if hnManager.userIsLoggedIn() {
      var user: User! = nil
      if let hnUser = hnManager.SessionUser {
        user = User(user: hnUser)
      }
      if completion { completion(user: user) }
    } else if let credentials = credentialStore.credentials() {
      // TODO: Do this in the app delegate.
      hackerNewsAPI.logInWithUsername(credentials.username, password: credentials.password) { (user: User!) in
        // TODO: Post a notification that the user was logged in.
        if completion { completion(user: user) }
      }
    } else {
      if completion { completion(user: nil) }
    }
  }
  
}
