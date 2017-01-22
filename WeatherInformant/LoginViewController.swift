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
    @IBOutlet weak var logoTopLayout: NSLayoutConstraint! // default 50
    
    @IBOutlet weak var txtFieldTopLayout: NSLayoutConstraint! // default 50
    
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
        
    }
    
    
    
    //MARK: IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        hideKeyboard()
        
        if hasLocalError() {

            return
        }
        
        if let username = usernameTextField.text {
            if let password = passwordTextField.text{
             
                //attempt login
                
                //if login successful  - dismiss - root VC will redirect to home
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
        
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField!) {
      
        _ = self.hasLocalError()
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
        
        //check for empty fields
        for (index,_) in textFields.enumerated() {
            
            //reset
            heightConstraints[index]?.constant = 0
            
            if let trimmedString = textFields[index]?.text?.trimmingCharacters(in: CharacterSet.whitespaces) {
                if index == 0 && trimmedString.characters.count < 8{
                    errorLables[index]?.text = "Username too short"
                    let newSize = errorLables[index]?.sizeThatFits(CGSize(width: (errorLables[index]?.frame.size.width)!, height: CGFloat.greatestFiniteMagnitude))
                    heightConstraints[index]?.constant = (newSize?.height)! + gap
                    hasError = true
                } else {
                    // check password length
                    if index == 1 && trimmedString.characters.count < 8 {
                        errorLables[index]?.text = "Password too short"
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
    
    
    //MARK: helper func
    func hideKeyboard() {
        
        self.view.endEditing(true)
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
