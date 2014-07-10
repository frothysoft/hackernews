//
//  ArticleTableViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController {
  
  var posts: [Post] = []
  var selectedPost: Post? = nil
  @IBOutlet var loadingIndicator : UIActivityIndicatorView
  let hackerNewsAPI: HackerNewsAPI
  let userDataAccess: UserDataAccess
  let articleSegueIdentifier = "articlesToArticle"
  let loginSegueIdentifier = "articlesToLogin"

  init(coder aDecoder: NSCoder!) {
    let objectsFactory = (UIApplication.sharedApplication().delegate as AppDelegate).objectsFactory
    hackerNewsAPI = objectsFactory.hackerNewsAPI
    userDataAccess = objectsFactory.userDataAccess
    super.init(coder: aDecoder)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    setUpPersonIcon()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    loadPosts()
  }

  func setUpPersonIcon() {
    var personImage = UIImage(named: "person")
    if userDataAccess.loggedInUser() {
      personImage = UIImage(named: "person-active")
    }
    navigationItem.rightBarButtonItem.image = personImage
  }

  func setUpTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100.0
  }
  
  func loadPosts() {
    loadingIndicator.startAnimating()
    hackerNewsAPI.loadPostsWithFilter(PostFilterType.Top) { (posts: [Post]!) in
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
    selectedPost = posts[indexPath.item]
    performSegueWithIdentifier(articleSegueIdentifier, sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if segue.identifier == articleSegueIdentifier { prepareForArticleSegue(segue, sender: sender) }
    else if segue.identifier == loginSegueIdentifier { prepareForLoginSegue(segue, sender: sender) }
  }
  
  func prepareForArticleSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if let articleViewController = segue.destinationViewController as? ArticleViewController {
      if let post = selectedPost { articleViewController.post = post }
    }
  }
  
  func prepareForLoginSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    segue.applyBlurToSourceViewBackground()
  }
  
}
