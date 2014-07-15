//
//  WebViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/15/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

  @IBOutlet var webView: UIWebView
  var URL: NSURL?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let url = URL {
      var request = NSURLRequest(URL: url)
      webView.loadRequest(request)
    }
  }
  
}
