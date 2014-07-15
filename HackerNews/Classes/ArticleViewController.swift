//
//  ArticleViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticleViewController: UITableViewController {
  
  var post: Post? = nil
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
        self.comments = comments
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return comments.count + 1
  }
  
  override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
    let id = cellIdentifierForIndexPath(indexPath)
    var oCell = tableView.dequeueReusableCellWithIdentifier(id) as? ArticleTableViewCell
    if let cell = oCell {
      if indexPath.row == 0 {
        if let p = post {
          cell.displayPost(p)
        }
      } else {
        let comment = comments[indexPath.row - 1]
        cell.displayComment(comment)
      }
    }
    return oCell
  }
  
  override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
    if indexPath.row == 0 {
      return "ArticleCell"
    } else {
      return "CommentCell"
    }
  }
  
}

