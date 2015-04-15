//
//  AppDelegate.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?
  let objectsFactory: ObjectsFactory
  
  init() {
    objectsFactory = HackerNewsObjectFactory()
    super.init()
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
    Mixpanel.sharedInstanceWithToken("19690ff61781b448f04504d6614e74cd")
    Mixpanel.sharedInstance().track("App Launched")
    HNManager.sharedManager().startSession()
    if let w = window { w.backgroundColor = UIColor.whiteColor() }
    return true
  }
  
}

