//
//  ArticleTableViewCell.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

@objc protocol ArticleTableViewCellDelegate {
  
  func articleTableViewCellDidPressUpvoteButton(cell: ArticleTableViewCell)
  func articleTableViewCellDidPressCommentButton(cell: ArticleTableViewCell)
  
}

class ArticleTableViewCell: UITableViewCell, UITextViewDelegate {
  
  @IBOutlet var typeImageView : UIImageView!
  @IBOutlet var headlineLabel : UILabel!
  @IBOutlet var usernameLabel : UILabel!
  @IBOutlet var pointsLabel : UILabel!
  @IBOutlet var commentsLabel : UILabel!
  @IBOutlet var descriptionLabel : UITextView!
  @IBOutlet var upvoteImageView: UIImageView!
  var delegate: ArticleTableViewCellDelegate?
  
  var isUpvoted: Bool = false {
  didSet { updateUpvoteButton() }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // TODO: Link detection is crashing due to some cell reuse issues.
    // TODO: This doesn't seem to be insetting the text all the way to the edge.
    if descriptionLabel { descriptionLabel.textContainerInset = UIEdgeInsetsZero }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // TODO: The headline label height isn't sizing properly until you scroll up and down.
    if headlineLabel { headlineLabel.preferredMaxLayoutWidth = headlineLabel.frame.size.width }
    self.updateConstraintsIfNeeded()
    self.layoutIfNeeded()
    super.layoutSubviews()
  }
  
  func displayPost(post: Post) {
    headlineLabel.text = post.title
    pointsLabel.text = "\(post.points)"
    commentsLabel.text = "\(post.commentCount)"
    typeImageView.image = post.typeImage()
    if descriptionLabel { descriptionLabel.text = "" }
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
  
  func updateUpvoteButton() {
    if !isUpvoted {
      upvoteImageView.image = UIImage(named: "icon-upvote")
      pointsLabel.textColor = UIColor.lightGreyTextColor()
    } else {
      upvoteImageView.image = UIImage(named: "icon-upvote-active")
      pointsLabel.textColor = UIColor.activeTextColor()
    }
  }
  
  @IBAction func upvoteButtonPressed(sender: AnyObject) {
    if let d = delegate { d.articleTableViewCellDidPressUpvoteButton(self) }
  }
  
  @IBAction func commentButtonPressed(sender: AnyObject) {
    if let d = delegate { d.articleTableViewCellDidPressCommentButton(self) }
  }
  
  func pulseUpvoteButton() {
    var duration = 0.5
    var delay = 0
    var key1 = { self.upvoteImageView.transform = CGAffineTransformMakeScale(1.5, 1.5) }
    var key2 = { self.upvoteImageView.transform = CGAffineTransformMakeScale(0.7, 0.7) }
    var key3 = { self.upvoteImageView.transform = CGAffineTransformMakeScale(1, 1) }
    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: .AllowUserInteraction, animations: { () in
      UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: key1)
      UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: key2)
      UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: key3)
    }, completion: nil)
  }
  
}
