//
//  CommentViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/17/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITextViewDelegate {

  @IBOutlet var commentBarButton: UIBarButtonItem!
  @IBOutlet var commentTextView: UITextView!
  @IBOutlet var loadingView: UIView!
  var hackerNewsAPI: HackerNewsAPI
  var post: Post?
  // TODO: Support commenting on comments
  
  init(coder aDecoder: NSCoder!) {
    let objectsFactory = (UIApplication.sharedApplication().delegate as AppDelegate).objectsFactory
    hackerNewsAPI = objectsFactory.hackerNewsAPI
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    commentTextView.becomeFirstResponder()
    commentBarButton.enabled = false
  }

  @IBAction func closeButtonPressed(sender: AnyObject!) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func commentButtonPressed(sender: AnyObject!) {
    if let p = post {
      commentTextView.resignFirstResponder()
      commentBarButton.title = "Posting..."
      loadingView.hidden = false
      hackerNewsAPI.replyToPost(p, text: commentTextView.text) { (success: Bool) in
        self.loadingView.hidden = true
        if success {
          // TODO: Notifiy the article to reload.
          self.dismissViewControllerAnimated(true, completion: nil)
        } else {
          self.commentBarButton.title = "Cound't post :("
        }
      }
    }
  }
  
  func textViewDidChange(textView: UITextView!) {
    commentBarButton.enabled = !textView.text.isEmpty
  }
  
}
