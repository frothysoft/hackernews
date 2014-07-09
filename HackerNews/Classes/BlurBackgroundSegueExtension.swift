//
//  BlurBackgroundSegueExtension.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/7/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {
  func applyBlurToSourceViewBackground() {
    var source = sourceViewController as UIViewController
    var snapshot = source.view.window.snapshotViewAfterScreenUpdates(false)
    var destination = destinationViewController as UIViewController
    var blur = UIBlurEffect(style: .Dark)
    var blurView = UIVisualEffectView(effect: blur)
    blurView.frame = destination.view.bounds
    destination.view.insertSubview(snapshot, atIndex: 0)
    destination.view.insertSubview(blurView, atIndex: 1)
  }
}
