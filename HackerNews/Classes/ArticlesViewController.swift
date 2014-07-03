//
//  ArticleTableViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController {
  
  var posts: HNPost[] = []
  @IBOutlet var loadingIndicator : UIActivityIndicatorView
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.estimatedRowHeight = UITableViewAutomaticDimension
    loadPosts()
  }
  
  func loadPosts() {
    loadingIndicator.startAnimating()
    HNManager.sharedManager().loadPostsWithFilter(PostFilterType.Top) { (posts: AnyObject[]!) in
      self.posts = []
      for object : AnyObject in posts {
        var post: HNPost = object as HNPost
        self.posts += post
      }
      self.loadingIndicator.stopAnimating()
      self.tableView.reloadData()
    }
  }
  
  override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
    let id = "ArticleCell"
    var cell = tableView.dequeueReusableCellWithIdentifier(id) as? ArticleTableViewCell
    
    let post = posts[indexPath.item]
    cell!.displayPost(post)
    
    return cell
  }
  
  override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  
}
