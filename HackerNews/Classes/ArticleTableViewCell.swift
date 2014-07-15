//
//  ArticleTableViewCell.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

  @IBOutlet var typeImageView : UIImageView
  @IBOutlet var headlineLabel : UILabel
  @IBOutlet var usernameLabel : UILabel
  @IBOutlet var pointsLabel : UILabel
  @IBOutlet var commentsLabel : UILabel
  @IBOutlet var descriptionLabel : UILabel
  
  func displayPost(post: Post) {
    println(post.title)
    headlineLabel.text = post.title
    pointsLabel.text = "\(post.points)"
    commentsLabel.text = "\(post.commentCount)"
    typeImageView.image = post.typeImage()
    displayUsername(post.username, timeCreatedString: post.timeCreatedString)
  }
  
  func displayComment(comment: Comment) {
    descriptionLabel.text = comment.text
    // TODO: Deal with the comments label. There is no number value for post comment upvotes.
    displayUsername(comment.username, timeCreatedString: comment.timeCreatedString)
  }
  
  func displayUsername(username: String, timeCreatedString: String) {
    // TODO: Show the time created in the top right of the cell.
    var info = String()
    if !username.isEmpty { info = username + " " }
    info += timeCreatedString
    usernameLabel.text = info
  }
  
}
