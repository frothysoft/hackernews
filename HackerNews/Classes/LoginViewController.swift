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
  let hackerNewsAPI: HackerNewsAPI
  let userDataAccess: UserDataAccess
  
  init(coder aDecoder: NSCoder!) {
    let objectsFactory = (UIApplication.sharedApplication().delegate as AppDelegate).objectsFactory
    hackerNewsAPI = objectsFactory.hackerNewsAPI
    userDataAccess = objectsFactory.userDataAccess
    super.init(coder: aDecoder)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    userInterface.startCanvasAnimation()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userInterface.interactionHandler = self
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  @IBAction func closeButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func logInForUsername(username: String, password: String) {
    userInterface.showLoadingView()
    hackerNewsAPI.logInWithUsername(username, password: password) { (user: User!) in
      self.userInterface.hideLoadingView()
      if !user {
        self.userInterface.showErrorMessage()
      } else {
        // TODO: We might also need to set some info with the people.set method.
        Mixpanel.sharedInstance().identify(user.username)
        self.userDataAccess.storeUser(user, password: password)
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
  }
  
}
