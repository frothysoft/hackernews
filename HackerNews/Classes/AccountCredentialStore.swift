//
//  AccountCredentialStore.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/9/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class AccountCredentialStore: CredentialStore {
  
  let identifier = "account"
  let service = "com.hackernews.user"
  var keychain = ACSimpleKeychain.defaultKeychain() as ACSimpleKeychain
  
  func storeCredentials(username: String, password: String) {
    keychain.storeUsername(username, password: password, identifier: identifier, forService: service)
  }

  func credentials() -> (username: String, password: String)! {
    if let credentials = keychain.credentialsForIdentifier(identifier, service: service) {
      let username: AnyObject? = credentials[ACKeychainUsername]
      let password: AnyObject? = credentials[ACKeychainPassword]
      if username && password {
        let usernameString = username as String
        let passwordString = password as String
        return (username: usernameString, password: passwordString)
      }
    }
    return nil
  }
  
  func removeCredentials() {
    keychain.deleteCredentialsForIdentifier(identifier, service: service)
  }
  
}
