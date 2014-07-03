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
  
  func displayPost(post: Post) {
    headlineLabel.text = post.title
    usernameLabel.text = post.username
    pointsLabel.text = "\(post.points)"
    commentsLabel.text = "\(post.commentCount)"
    typeImageView.image = post.typeImage
  }
  
}
