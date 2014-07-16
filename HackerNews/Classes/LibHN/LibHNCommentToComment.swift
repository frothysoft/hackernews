//
//  LibHNCommentToComment.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/14/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

extension Comment {
  init(comment: HNComment) {
    self = Comment(commentId: comment.CommentId, username: comment.Username, text: comment.Text, timeCreatedString: comment.TimeCreatedString, replyURLString: comment.ReplyURLString, level: Int(comment.Level), upvoteURLAddition: comment.UpvoteURLAddition)
  }
}
