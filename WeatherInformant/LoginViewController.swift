//
//  LoginViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 21/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var usernameErrorHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordErrorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoTopLayout: NSLayoutConstraint! // default 60
    
    @IBOutlet weak var txtFieldTopLayout: NSLayoutConstraint! // default 55
    
    let gap : CGFloat = 10.0
    
    var username: String = ""
    
    var keyboardUp = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    
    
    //MARK: IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        clearHighlight()
        hideKeyboard()
        enableAllTextFields(false)
        
        if hasLocalError() {
            enableAllTextFields(true)
            return
        }
        
        if let username = usernameTextField.text {
            if let password = passwordTextField.text{
                
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        hideKeyboard()
        UIApplication.shared.statusBarStyle = .lightContent
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField!) {
        clearHighlight()
        //        if let borderedTextField = textField as? BorderedTextFieldWithIcon {
        //            borderedTextField.showHighlight(true)
        //        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            hideKeyboard()
            self.loginButtonPressed(self.loginButton)
        }
        
        return true
    }
    
    
    
    
    
    
    func hasLocalError()->Bool {
        var hasError = false
        
        var textFields = [usernameTextField,passwordTextField]
        var errorLables = [userNameErrorLabel,passwordErrorLabel]
        var heightConstraints = [usernameErrorHeight,passwordErrorHeight]
        var errorMessages = ["signup.login.error.email_phone_invalid","signup.login.error.passwordmissing"]
        
        //check for empty fields
        for (index,_) in textFields.enumerated() {
            
            //reset
            // textFields[index]?.showHighlight(false)
            heightConstraints[index]?.constant = 0
            
            if let trimmedString = textFields[index]?.text?.trimmingCharacters(in: CharacterSet.whitespaces) {
                if trimmedString.characters.count == 0 {
                    //   textFields[index]?.showHighlight(true)
                    errorLables[index]?.text = "Empty"
                    let newSize = errorLables[index]?.sizeThatFits(CGSize(width: (errorLables[index]?.frame.size.width)!, height: CGFloat.greatestFiniteMagnitude))
                    heightConstraints[index]?.constant = (newSize?.height)! + gap
                    hasError = true
                } else {
                    // check password length
                    if index == 1 && trimmedString.characters.count < 6 {
                        //  textFields[index]?.showHighlight(true)
                        errorLables[index]?.text = "password too short"
                        let newSize = errorLables[index]?.sizeThatFits(CGSize(width: (errorLables[index]?.frame.size.width)!, height: CGFloat.greatestFiniteMagnitude))
                        heightConstraints[index]?.constant = (newSize?.height)! + gap
                        hasError = true
                    }
                    
                }
            }
        }
        
        self.view.layoutIfNeeded()
        return hasError
    }
    
    
    func highlightTextFieldWithError(_ errorCode:String) {
        
        switch errorCode {
            
        case "EmailOrPhoneRequired","InvalidEmailAddress","InvalidPhone","UserNotFoundEmail","UserNotFoundPhone","UsernameNotReadable","DuplicatePhoneUserFound","UserNotSignedUp","UserNotActive":
            
           
            
            // usernameTextField.showHighlight(true)
            userNameErrorLabel.text = errorCode//ErrorCode.localizedErrorString(withKey: errorCode)
            let newSize =  userNameErrorLabel.sizeThatFits(CGSize(width: userNameErrorLabel.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            usernameErrorHeight.constant = newSize.height + gap
            
        case "PasswordMissing","CouldNotLogIn":
            // passwordTextField.showHighlight(true)
            passwordErrorLabel.text = errorCode //ErrorCode.localizedErrorString(withKey: errorCode)
            let newSize =  passwordErrorLabel.sizeThatFits(CGSize(width: passwordErrorLabel.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            passwordErrorHeight.constant = newSize.height + gap
            
        default:
            clearHighlight()
            passwordErrorLabel.text = errorCode//Localizer.sharedInstance().localizedString(forKey: "signup.error.unknown")!
            let newSize =  passwordErrorLabel.sizeThatFits(CGSize(width: passwordErrorLabel.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            passwordErrorHeight.constant = newSize.height + gap
        }
    }
    
   
    
    //MARK: helper func
    func hideKeyboard() {
        
        self.view.endEditing(true)
    }
    
    func clearHighlight() {
        //  usernameTextField.showHighlight(false)
        //  passwordTextField.showHighlight(false)
    }
    
    func enableAllTextFields(_ enable:Bool) {
        let textFields = [usernameTextField,passwordTextField]
        for oneTextField in textFields {
            oneTextField?.isEnabled = enable
        }
    }
    
    
    
    //TODO: move to global
    func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        
        if !keyboardUp{
            
            UIView.animate(withDuration: 2.5){
                
                self.logoTopLayout?.constant = 0
                
                self.txtFieldTopLayout?.constant = 0
            }
            
            keyboardUp = true
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 1){
            
            self.txtFieldTopLayout?.constant = 50
            
            self.logoTopLayout?.constant = 50
        }
        
        keyboardUp = false
    }
    
    
}
