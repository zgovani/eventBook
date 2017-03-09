//
//  SignUpViewController.swift
//  FirebaseDemo
//
//  Created by Zach Govani on 2/12/17.
//  Copyright © 2017 Zach Govani. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var nameTextField: UITextField!
    var signupButton: UIButton!
    var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.51, green:0.70, blue:0.82, alpha:1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupTitle()
        setupTextFields()
        setupButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupTitle() {
        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 0.4 * UIScreen.main.bounds.height))
        titleLabel.font = UIFont.init(name: "Garamond", size: 45)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.text = "Sign Up"
        view.addSubview(titleLabel)
    }
    func setupTextFields() {
        emailTextField = UITextField(frame: CGRect(x: 10, y: 0.65 * UIScreen.main.bounds.height - 52, width: UIScreen.main.bounds.width - 20, height: 50))
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
        passwordTextField.font = UIFont.init(name: "Garamond", size: 20)
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layoutIfNeeded()
        passwordTextField.layer.borderColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0).cgColor
        passwordTextField.backgroundColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0)
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.darkGray
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        
        nameTextField = UITextField(frame: CGRect(x: 10, y: passwordTextField.frame.maxY + 2, width: UIScreen.main.bounds.width - 20, height: 50))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.placeholder = "Name"
        nameTextField.font = UIFont.init(name: "Garamond", size: 20)
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.layoutIfNeeded()
        nameTextField.layer.borderColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0).cgColor
        nameTextField.backgroundColor = UIColor(red:0.75, green:0.84, blue:0.89, alpha:1.0)
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.masksToBounds = true
        nameTextField.textColor = UIColor.darkGray
        nameTextField.layer.cornerRadius = 5
        nameTextField.returnKeyType = .done
        nameTextField.delegate = self
        self.view.addSubview(nameTextField)
    }
    
    func setupButtons() {
        
        signupButton = UIButton(frame: CGRect(x: 10, y: nameTextField.frame.maxY + 20, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
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
        
        goBackButton = UIButton(frame: CGRect(x: 0.5 * UIScreen.main.bounds.width + 10, y: nameTextField.frame.maxY + 20, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
        goBackButton.layoutIfNeeded()
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.setTitleColor(UIColor.darkGray, for: .normal)
        goBackButton.layer.borderWidth = 2.0
        goBackButton.layer.cornerRadius = 3.0
        goBackButton.layer.borderColor = UIColor.darkGray.cgColor
        goBackButton.layer.masksToBounds = true
        goBackButton.addTarget(self, action: #selector(goBackButtonClicked), for: .touchUpInside)
        goBackButton.titleLabel?.font = Constants.garamond
        goBackButton.titleLabel?.font = goBackButton.titleLabel?.font.withSize(20)
        self.view.addSubview(goBackButton)
        
    }
    
    
    func signupButtonClicked() {
        signupButton.isEnabled = false
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let name = nameTextField.text!
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error == nil {
                let ref = FIRDatabase.database().reference().child("Users").child((FIRAuth.auth()?.currentUser?.uid)!)
                ref.setValue(["name": name, "email": email])
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.nameTextField.text = ""
                self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
                self.signupButton.isEnabled = true
                
            }
            else {
                print(error.debugDescription)
            }
        })
    }
    
    func goBackButtonClicked() {
        self.dismiss(animated: true, completion: nil)
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
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
