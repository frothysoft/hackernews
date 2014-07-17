//
//  ArticleTableViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController, ArticleTableViewCellDelegate {
  
  var posts: [Post] = []
  var selectedPost: Post? = nil
  @IBOutlet var loadingIndicator : UIActivityIndicatorView
  let hackerNewsAPI: HackerNewsAPI
  let userDataAccess: UserDataAccess
  var user: User?
  let articleSegueIdentifier = "articlesToArticle"
  let webViewSegueIdentifier = "articlesToWebView"
  let loginSegueIdentifier = "articlesToLogin"

  init(coder aDecoder: NSCoder!) {
    let objectsFactory = (UIApplication.sharedApplication().delegate as AppDelegate).objectsFactory
    hackerNewsAPI = objectsFactory.hackerNewsAPI
    userDataAccess = objectsFactory.userDataAccess
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    setUpPullToRefresh()
    // TODO: Monitor user updates using a user data access observer and reload posts.
    getLoggedInUser() { () in
      self.loadPosts()
    }
  }
  
  func getLoggedInUser(completion: (() -> Void)!) {
    loadingIndicator.startAnimating()
    userDataAccess.loggedInUser() { (user: User!) in
      self.loadingIndicator.stopAnimating()
      self.user = user
      self.setUpPersonIcon()
      if completion { completion() }
    }
  }

  func setUpPersonIcon() {
    var personImage = UIImage(named: "person")
    if user { personImage = UIImage(named: "person-active") }
    navigationItem.rightBarButtonItem.image = personImage
  }

  func setUpTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100.0
  }

  func setUpPullToRefresh() {
    var refresh = UIRefreshControl()
    refresh.addTarget(self, action: "loadPosts", forControlEvents: .ValueChanged)
    refreshControl = refresh
  }
  
  func loadPosts() {
    loadingIndicator.startAnimating()
    hackerNewsAPI.loadPostsWithFilter(PostFilterType.Top) { (posts: [Post]!) in
      self.posts = posts
      self.loadingIndicator.stopAnimating()
      self.tableView.reloadData()
      if self.refreshControl.refreshing {
        SimpleAudioPlayer.playFile("magic-refresh.aif")
        self.refreshControl.endRefreshing()
      }
    }
  }
  
  override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
    let id = "ArticleCell"
    var cell = tableView.dequeueReusableCellWithIdentifier(id) as? ArticleTableViewCell
    let post = posts[indexPath.item]
    if let c = cell {
      c.delegate = self
      c.displayPost(post)
      // TODO: Ask another object if the user has upvoted this post.
      if user && !post.upvoteURLAddition {
        c.isUpvoted = true
      } else {
        c.isUpvoted = false
      }
    }
    return cell
  }
  
  override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    selectedPost = posts[indexPath.item]
    if let post = selectedPost {
      if UIApplication.sharedApplication().canOpenURL(NSURL(string: post.urlString)) {
        performSegueWithIdentifier(webViewSegueIdentifier, sender: self)
      } else {
        performSegueWithIdentifier(articleSegueIdentifier, sender: self)
      }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if segue.identifier == articleSegueIdentifier { prepareForArticleSegue(segue, sender: sender) }
    else if segue.identifier == loginSegueIdentifier { prepareForLoginSegue(segue, sender: sender) }
    else if segue.identifier == webViewSegueIdentifier { prepareForWebViewSegue(segue, sender: sender) }
  }
  
  func prepareForArticleSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if let articleViewController = segue.destinationViewController as? ArticleViewController {
      if let post = selectedPost { articleViewController.post = post }
    }
  }
  
  func prepareForLoginSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    segue.applyBlurToSourceViewBackground()
  }
  
  func prepareForWebViewSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if let webViewController = segue.destinationViewController as? WebViewController {
      if let post = selectedPost {
        webViewController.URL = NSURL(string: post.urlString)
        webViewController.post = post
      }
    }
  }

  func articleTableViewCellDidPressUpvoteButton(cell: ArticleTableViewCell) {
    var indexPath = tableView.indexPathForCell(cell)
    selectedPost = posts[indexPath.item]
    if let post = selectedPost {
      // TODO: Ask an upvoter if the user has not upvoted this post yet.
      if user && post.upvoteURLAddition {
        SimpleAudioPlayer.playFile("bubble-pop-upvote.mp3")
        cell.pulseUpvoteButton()
        cell.isUpvoted = true
        // TODO: Update the post outside of this view controller.
        var updatedPost = Post(postId: post.postId, title: post.title, username: post.username, points: post.points + 1, commentCount: post.commentCount, timeCreatedString: post.timeCreatedString, urlString: post.urlString, type: post.type, upvoteURLAddition: nil)
        cell.displayPost(updatedPost)
        var posts = self.posts
        posts[indexPath.item] = updatedPost
        self.posts = posts
        hackerNewsAPI.upvotePost(post, completion: nil)
      }
    }
  }

  func articleTableViewCellDidPressCommentButton(cell: ArticleTableViewCell) {
    var indexPath = tableView.indexPathForCell(cell)
    selectedPost = posts[indexPath.item]
    performSegueWithIdentifier(articleSegueIdentifier, sender: self)
  }
  
}
