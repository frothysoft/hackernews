//
//  ArticleViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticleViewController: UITableViewController {
  
  var post: Post?
  var postText: String? = nil // TODO: Remove this hack when the text is included in the Post.
  let hackerNewsAPI: HackerNewsAPI
  var comments: [Comment] = []
  
  init(coder aDecoder: NSCoder!) {
    let objectsFactory = (UIApplication.sharedApplication().delegate as AppDelegate).objectsFactory
    hackerNewsAPI = objectsFactory.hackerNewsAPI
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    loadComments()
  }
  
  func setUpTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
  }

  func loadComments() {
    if let p = post {
      hackerNewsAPI.loadCommentsForPost(p) { (comments: [Comment]!) in
        // TODO: Do this in the hacker news API class.
        if (p.type == PostType.AskHN || p.type == PostType.Jobs) {
          let specialComment = comments[0]
          self.postText = specialComment.text
          self.comments = Array(comments[1..<comments.count])
        } else {
          self.comments = comments
        }
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return comments.count + 1
  }
  
  override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
    let id = cellIdentifierForIndexPath(indexPath)
    var cell = tableView.dequeueReusableCellWithIdentifier(id) as? ArticleTableViewCell
    if let c = cell {
      if indexPath.row == 0 {
        if let p = post {
          c.displayPost(p)
          // TODO: Remove this hack when the post has text.
          if let text = postText { c.descriptionLabel.text = text }
        }
      } else {
        let comment = comments[indexPath.row - 1]
        c.displayComment(comment)
      }
    }
    return cell
  }
  
  override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if indexPath.row == 0 {
      // TODO: Navigate back if the web view is already on the stack.
      if let p = post { performSegueWithIdentifier("articleToWebView", sender: self) }
    }
  }
  
  func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
    if indexPath.row == 0 {
      return "ArticleCell"
    } else {
      return "CommentCell"
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if let webViewController = segue.destinationViewController as? WebViewController {
      if let p = post {
        webViewController.URL = NSURL(string: p.urlString)
        webViewController.post = p
      }
    }
  }
  
}

