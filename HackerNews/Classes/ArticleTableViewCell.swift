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
  @IBOutlet var dateLabel : UILabel
  
  func displayPost(post: HNPost) {
    headlineLabel.text = post.Title
    usernameLabel.text = post.Username
    pointsLabel.text = "\(post.Points)"
    commentsLabel.text = "\(post.CommentCount)"
    var type = post.valueForKey("Type").integerValue
    if type == 1 {
      typeImageView.image = UIImage(named: "badge-ask")
    } else if type == 2 {
      typeImageView.image = UIImage(named: "badge-job")
    } else if post.Title.bridgeToObjectiveC().containsString("Show HN: ") {
      typeImageView.image = UIImage(named: "badge-show")
    } else {
      typeImageView.image = nil
    }
  }
  
}
