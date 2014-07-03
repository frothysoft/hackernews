//
//  ArticleTableViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController {
  
  var posts: Post[] = []
  @IBOutlet var loadingIndicator : UIActivityIndicatorView
  let hackerNewsAPI: HackerNewsAPI
  
  init(coder aDecoder: NSCoder!) {
    let objectsFactory = (UIApplication.sharedApplication().delegate as AppDelegate).objectsFactory
    hackerNewsAPI = objectsFactory.hackerNewsAPI
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadPosts()
  }
  
  func loadPosts() {
    loadingIndicator.startAnimating()
    hackerNewsAPI.loadPostsWithFilter(PostFilterType.Top) { (posts: Post[]!) in
      self.posts = posts
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
