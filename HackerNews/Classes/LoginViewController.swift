//
//  LoginViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

protocol LoginInteractionHandler {
  func logInForUsername(username: String, password: String)
}

class LoginViewController: UIViewController, LoginInteractionHandler {
  
  @IBOutlet var userInterface: DialogView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userInterface.interactionHandler = self
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  func logInForUsername(username: String, password: String) {
    userInterface.showLoadingView()
    HNManager.sharedManager().loginWithUsername(username, password: password) { (user: HNUser!) in
      self.userInterface.hideLoadingView()
      if user == nil {
        self.userInterface.showErrorMessage()
      } else {
        self.performSegueWithIdentifier("loginToHomeScene", sender: self)
      }
    }
  }
}
