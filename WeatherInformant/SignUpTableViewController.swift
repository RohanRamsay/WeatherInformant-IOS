//
//  SingnUpTableViewController.swift
//  WeatherInformant
//
//  Created by Ramsay on 21/01/17.
//  Copyright © 2017 Ramsay.dummyIOS. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var usernameError: UILabel!
    
    @IBOutlet weak var firstnameField: UITextField!
    
    @IBOutlet weak var firstnameError: UILabel!
    
    @IBOutlet weak var lastnameField: UITextField!
    
    @IBOutlet weak var lastnameError: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var confirmPasswordError: UILabel!
    
    var errorStatus = [false, false, false, false, false, false]
    
    var errorMessages = ["", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinner.isHidden = true
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if errorStatus[indexPath.row] {
            
            return 62
        }
    
           return 44
    }
    
    @IBAction func signupButtonClick(_ sender: Any) {
        
        self.view.endEditing(true)
       
        if self.performValidityCheck(){
            //all valid
            
            self.spinner.isHidden = false
            self.view.isUserInteractionEnabled = false
            
            
            WeatherInformantBackendService.signup(username: self.usernameField.text!,
                                                  password: self.passwordField.text!,
                                                  firstname: self.firstnameField.text!,
                                                  lastname: self.lastnameField.text!,
                                                  email: self.emailField.text!,
                                                  completionHandler: {
                                                    
                                                    _ in
                                                    
                                                    self.spinner.isHidden = true
                                                    self.view.isUserInteractionEnabled = true
                                                    
                                                    self.saveLoggedInUser()
                                                    //if sign up successful - login - dismiss login vc - go to root.
                                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let controller = storyboard.instantiateViewController(withIdentifier: "RootViewController")
                                                    
                                                    UIApplication.shared.keyWindow?.rootViewController = controller
            },
                                                  errorHandler: {
                                                    
                                                    errorMsg in
                                                    
                                                    self.showAlertWith(message: errorMsg)
            })
            
            return
        }
        
            self.tableView.reloadData()
    }
    
    
    func performValidityCheck() -> Bool{
        
        if isAnyFieldEmpty(){
            
            return false
        }
        
        if isAnyLengthInvalid(){
            
            return false
        }
        
        if !isEmailValid(){
            
            self.errorStatus[3] = true
            self.emailError.isHidden = false
            self.emailError.text = "Email not valid"

            return false
        }
        else{
            self.errorStatus[3] = false
            self.emailError.isHidden = true
        }
        
        if self.passwordField.text != self.confirmPasswordField.text {
            
            self.errorStatus[5] = true
            self.confirmPasswordError.isHidden = false
            self.confirmPasswordError.text = "Passwords do not match"
            return false
        }
        else{
            self.errorStatus[5] = false
            self.confirmPasswordError.isHidden = true
        }
        return true
    }
    
    func isAnyFieldEmpty() -> Bool{
        
        var empty = false
        
        if self.usernameField.text == "" {
            
            empty = true
            self.usernameError.text = "Username cannot be empty"
        }
        
        self.errorStatus[0] = self.usernameField.text == ""
        self.usernameError.isHidden = self.usernameField.text != ""
        
        if self.firstnameField.text == "" {
            
            empty = true
            self.firstnameError.text = "Firstname cannot be empty"
        }
        
        self.errorStatus[1] = self.firstnameField.text == ""
        self.firstnameError.isHidden = self.firstnameField.text != ""
        
        if self.lastnameField.text == "" {
            
            empty = true
            self.lastnameError.text = "Lastname cannot be empty"
        }
        
        self.errorStatus[2] = self.lastnameField.text == ""
        self.lastnameError.isHidden = self.lastnameField.text != ""
        
        if self.emailField.text == "" {
            
            empty = true
            self.emailError.text = "Email cannot be empty"
        }
        
        self.errorStatus[3] = self.emailField.text == ""
        self.emailError.isHidden = self.emailField.text != ""
        
        if self.passwordField.text == "" {
            
            empty = true
            self.passwordError.text = "Password cannot be empty"
        }
        self.errorStatus[4] = self.passwordField.text == ""
        self.passwordError.isHidden = self.passwordField.text != ""
        
        return empty
    }
    
    
    func isAnyLengthInvalid() -> Bool{
        
        var invalid = false
        
        if (self.usernameField.text?.characters.count)! < 8 {
            
            invalid = true
            self.usernameError.text = "Username must have minimum 8 characters"
        }
        
        self.errorStatus[0] = (self.usernameField.text?.characters.count)! < 8
        self.usernameError.isHidden = (self.usernameField.text?.characters.count)! >= 8
        
        
        if (self.passwordField.text?.characters.count)! < 8 {
            
            invalid = true
            self.passwordError.text = "Password must have minimum 8 characters"
        }
        self.errorStatus[4] = (self.passwordField.text?.characters.count)! < 8
        self.passwordError.isHidden = (self.passwordField.text?.characters.count)! >= 8
        return invalid
    }
    
    func isEmailValid() -> Bool{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: self.emailField.text)
    }
    
    
    func saveLoggedInUser( ){
        
        //to simulate cookies
        UserDefaults.standard.set(self.usernameField.text, forKey: "userid")
        UserDefaults.standard.set(self.firstnameField.text, forKey: "firstname")
        UserDefaults.standard.set(self.lastnameField.text, forKey: "lastname")
        UserDefaults.standard.set(self.passwordField.text, forKey: "password")
        UserDefaults.standard.set("user", forKey: "role")
        UserDefaults.standard.set(self.emailField.text, forKey: "email")
        UserDefaults.standard.set(Date(), forKey: "joinedon")
        
        UserDefaults.standard.synchronize()
    }
    
    func showAlertWith(message: String?){
        
        self.spinner.isHidden = true
        self.view.isUserInteractionEnabled = true
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}


