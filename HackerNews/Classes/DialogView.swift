//
//  DialogView.swift
//  HackerNews
//
//  Created by Josh Berlin on 7/3/14.
//  Copyright (c) 2014 Frothy Software. All rights reserved.
//

import UIKit

class DialogView: CSAnimationView, UITextFieldDelegate {
  
  var interactionHandler: LoginInteractionHandler? = nil
  
  @IBOutlet var logInButton : UIButton!
  @IBOutlet var heightConstraint: NSLayoutConstraint!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var emailImageView: UIImageView!
  @IBOutlet var passwordImageView: UIImageView!
  @IBOutlet var loadingView: UIView!
  
  var showErrorHeight: CGFloat = 0.0
  
  @IBAction func logInButtonPressed(sender: AnyObject) {
    hideKeyboard()    
    if let ih = interactionHandler { ih.logInForUsername(emailTextField.text, password: passwordTextField.text) }
  }
  
  override func willMoveToSuperview(newSuperview: UIView!) {
    super.willMoveToSuperview(newSuperview)
    showErrorHeight = frame.size.height + 40.0
  }
  
  func hideKeyboard() {
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
  }
  
  func showErrorMessage() {
    shakeLoginButton()
    growDialogView()
  }
  
  func shakeLoginButton() {
    var moveRight = { self.logInButton.transform = CGAffineTransformMakeTranslation(10, 0) }
    var moveLeft = { self.logInButton.transform = CGAffineTransformMakeTranslation(-10, 0) }
    var backToNormal = { self.logInButton.transform = CGAffineTransformMakeTranslation(0, 0) }
    UIView.animateWithDuration(0.1, animations: moveRight) { completed in
      UIView.animateWithDuration(0.1, animations: moveLeft) { completed in
        UIView.animateWithDuration(0.1, animations: backToNormal)
      }
    }
  }
  
  func growDialogView() {
    self.heightConstraint.constant = 320
    UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
      if self.bounds.height != self.showErrorHeight {
        var showErrorFrame = self.frame
        showErrorFrame.size.height = self.showErrorHeight
        self.frame = showErrorFrame
      }
    }, completion: nil)
  }
  
  func showLoadingView() {
    loadingView.hidden = false
  }
  
  func hideLoadingView() {
    loadingView.hidden = true
  }
  
  func textFieldDidBeginEditing(textField: UITextField!) {
    textField.background = UIImage(named: "input-outline-active")
    if textField == emailTextField {
      emailImageView.image = UIImage(named: "icon-mail-active")
    } else if textField == passwordTextField {
      passwordImageView.image = UIImage(named: "icon-password-active")
    }
  }
  
  func textFieldDidEndEditing(textField: UITextField!) {
    textField.background = UIImage(named: "input-outline")
    if textField == emailTextField {
      emailImageView.image = UIImage(named: "icon-mail")
    } else if textField == passwordTextField {
      passwordImageView.image = UIImage(named: "icon-password")
    }
  }
  
  func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
    if textField == emailTextField {
      if textField.text.utf16Count > 20 {
        self.emailImageView.hidden = true
      } else {
        self.emailImageView.hidden = false
      }
    }
    
    return true
  }
}
