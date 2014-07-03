//
//  ArticleViewController.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/2/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
  
  @IBAction func unwindFromView(segue: UIStoryboardSegue) {
    navigationController.popViewControllerAnimated(true)
  }

}

