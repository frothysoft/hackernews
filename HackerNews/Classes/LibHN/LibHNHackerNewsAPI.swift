//
//  LibHNHackerNewsAPI.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class LibHNHackerNewsAPI: HackerNewsAPI {
  
  func logInWithUsername(username: String, password: String, completion: ((User!) -> Void)!) {
    HNManager.sharedManager().loginWithUsername(username, password: password) { (hnUser: HNUser!) in
      var user: User! = nil
      if hnUser {
        user = User(user: hnUser)
      }
      if completion { completion(user) }
    }
  }
  
  func loadPostsWithFilter(filter: PostFilterType, completion: (([Post]!) -> Void)!) {
    HNManager.sharedManager().loadPostsWithFilter(PostFilterType.Top) { (hnPosts: [AnyObject]!) in
      var posts: [Post] = []
      if hnPosts {
        for hnPost in hnPosts as [HNPost] {
          var post = Post.postFromHNPost(hnPost)
          posts += post
        }
      }
      if completion { completion(posts) }
    }
  }
  
  func loadCommentsForPost(post: Post, completion: (([Comment]!) -> Void)!) {
    // The LibHN API only needs a HNPost with an id and type to load the comments.
    var hnPost = HNPost()
    hnPost.PostId = post.postId
    hnPost.Type = post.type
    HNManager.sharedManager().loadCommentsFromPost(hnPost) { (hnComments: [AnyObject]!) in
      var comments: [Comment] = []
      if hnComments {
        for hnComment in hnComments as [HNComment] {
          // This is a hack since LibHN adds the ask text and job text as a special first comment in the list.
          // TODO: Add text to the Post.
          if hnComment.Type == HNCommentType.AskHN || hnComment.Type == HNCommentType.Jobs {
            comments += Comment(commentId: "", username: "", text: hnComment.Text, timeCreatedString: "", replyURLString: "", level: 0, upvoteURLAddition: "")
          } else {
            var comment = Comment(comment: hnComment)
            comments += comment
          }
        }
      }
      if completion { completion(comments) }
    }
  }
  
  func upvotePost(post: Post, completion: ((success: Bool) -> Void)!) {
    upvoteHNObjectWithUpvoteURLAddition(post.upvoteURLAddition, completion)
  }
  
  func upvoteComment(comment: Comment, completion: ((success: Bool) -> Void)!) {
    upvoteHNObjectWithUpvoteURLAddition(comment.upvoteURLAddition, completion)
  }
  
  func upvoteHNObjectWithUpvoteURLAddition(upvoteURLAddition: String?, completion: ((success: Bool) -> Void)!) {
    if let upvoteURL = upvoteURLAddition {
      var hnPost = HNPost()
      hnPost.UpvoteURLAddition = upvoteURL
      HNManager.sharedManager().voteOnPostOrComment(hnPost, direction: VoteDirection.Up) { (success: Bool) in
        if completion { completion(success: success) }
      }
    } else {
      if completion { completion(success: false) }
    }
  }
  
  func replyToPost(post: Post, text: String, completion: ((success: Bool) -> Void)!) {
    replyToHNObjectWithItemId(post.postId, text: text, completion)
  }
  
  func replyToComment(comment: Comment, text: String, completion: ((success: Bool) -> Void)!) {
    replyToHNObjectWithItemId(comment.commentId, text: text, completion)
  }
  
  func replyToHNObjectWithItemId(itemId: String?, text: String, completion: ((success: Bool) -> Void)!) {
    if let id = itemId {
      var hnPost = HNPost()
      hnPost.PostId = id
      HNManager.sharedManager().replyToPostOrComment(hnPost, withText: text) { (success: Bool) in
        if completion { completion(success: success) }
      }
    } else {
      if completion { completion(success: false) }
    }
  }
  
}
