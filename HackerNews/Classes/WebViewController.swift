//
//  WebViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/15/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

  // TODO: Use WKWebView.
  @IBOutlet var webView: UIWebView!
  @IBOutlet var commentsButton: UIButton!
  var URL: NSURL?
  var post: Post?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let url = URL {
      var request = NSURLRequest(URL: url)
      webView.loadRequest(request)
    }
    if let p = post {
      var title = "\(p.commentCount) Comments"
      commentsButton.setTitle(title, forState: .Normal)
    }
  }

  @IBAction func commentsButtonPressed(sender: AnyObject) {
    performSegueWithIdentifier("webViewToArticle", sender: self)
  }
  
  @IBAction func shareButtonPressed(sender: AnyObject) {
    if let p = post {
      var shareString = "\(p.title): "
      if let url = URL {
        var activityViewController = UIActivityViewController(activityItems: [shareString, url], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
      }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if let articleViewController = segue.destinationViewController as? ArticleViewController {
      if let p = post { articleViewController.post = post }
    }
  }
}
