//
//  LoginViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 21/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
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
        
        self.spinner.isHidden = true

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
                
                self.spinner.isHidden = false
                self.view.isUserInteractionEnabled = false
                //attempt login
                WeatherInformantBackendService.login(username: username,
                                                     password: password,
                                                     completionHandler: {
                                                        
                                                        user in
                                                        
                                                        self.spinner.isHidden = true
                                                        self.view.isUserInteractionEnabled = true
                                                        
                                                        self.saveLoggedInUser(user: user)
                                                        
                                                        //if login successful  - dismiss - root VC will redirect to home
                                                        self.dismiss(animated: true, completion: nil)
                },
                                                     errorHandler: self.showAlertWith(message:))
                
                
                
            }
        }
    }
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField!) {
        
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
    
    func showAlertWith(message: String?){
        
        self.spinner.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func saveLoggedInUser( user: JSON?){
     
        //to simulate cookies
        UserDefaults.standard.set(user?["userid"].description, forKey: "userid")
        UserDefaults.standard.set(user?["firstname"].description, forKey: "firstname")
        UserDefaults.standard.set(user?["lastname"].description, forKey: "lastname")
        UserDefaults.standard.set(user?["password"].description, forKey: "password")
        UserDefaults.standard.set(user?["role"].description, forKey: "role")
        UserDefaults.standard.set(user?["email"].description, forKey: "email")
        UserDefaults.standard.set(user?["joinedon"].object, forKey: "joinedon")

        UserDefaults.standard.synchronize()
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
