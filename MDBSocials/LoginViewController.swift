//
//  LoginViewController.swift
//  FirebaseDemo
//
//  Created by Zach Govani on 2/24/17.
//  Copyright © 2017 Zach Govani. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var appTitle: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.51, green:0.70, blue:0.82, alpha:1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupTitle()
        setupTextFields()
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupTitle() {
        appTitle = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 0.4 * UIScreen.main.bounds.height))
        appTitle.font = UIFont.init(name: "Garamond", size: 45)
        appTitle.textColor = UIColor.darkGray
        appTitle.adjustsFontSizeToFitWidth = true
        appTitle.textAlignment = .center
        appTitle.text = "Socials"
        
        view.addSubview(appTitle)
    }
    
    func setupTextFields() {
        emailTextField = UITextField(frame: CGRect(x: 10, y: 0.65 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 50))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.init(name: "Garamond", size: 20)
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0).cgColor
        emailTextField.backgroundColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0)
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.darkGray
        emailTextField.layer.cornerRadius = 5
        emailTextField.returnKeyType = .done
        emailTextField.delegate = self
        self.view.addSubview(emailTextField)
        
        
        passwordTextField = UITextField(frame: CGRect(x: 10, y: emailTextField.frame.maxY + 2, width: UIScreen.main.bounds.width - 20, height: 50))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0).cgColor
        passwordTextField.backgroundColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0)
        emailTextField.font = UIFont.init(name: "Garamond", size: 20)
        emailTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = UIColor.darkGray
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        
        loginButton = UIButton(frame: CGRect(x: 10, y: passwordTextField.frame.maxY + 20, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
        loginButton.layoutIfNeeded()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor.darkGray, for: .normal)
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.cornerRadius = 3.0
        loginButton.layer.borderColor = UIColor.darkGray.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        loginButton.titleLabel?.font = Constants.garamond
        loginButton.titleLabel?.font = loginButton.titleLabel?.font.withSize(20)
        self.view.addSubview(loginButton)
        
        signupButton = UIButton(frame: CGRect(x: 0.5 * UIScreen.main.bounds.width + 10, y: passwordTextField.frame.maxY + 20, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
        signupButton.layoutIfNeeded()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(UIColor.darkGray, for: .normal)
        signupButton.layer.borderWidth = 2.0
        signupButton.layer.cornerRadius = 3.0
        signupButton.layer.borderColor = UIColor.darkGray.cgColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        signupButton.titleLabel?.font = Constants.garamond
        signupButton.titleLabel?.font = signupButton.titleLabel?.font.withSize(20)
        self.view.addSubview(signupButton)
    }
    
    func loginButtonClicked(sender: UIButton!) {
        print("logging")
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if email != "" && password != "" {
            loginButton.isEnabled = false
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
                if error == nil {
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
                    self.loginButton.isEnabled = true
                }
            })
        }
    }
    
    func signupButtonClicked(sender: UIButton!) {
        performSegue(withIdentifier: "toSignup", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

