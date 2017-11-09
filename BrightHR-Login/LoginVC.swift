//
//  LoginVC.swift
//  BrightHR-Login
//
//  Created by Joshua Colley on 09/11/2017.
//  Copyright © 2017 Joshua Colley. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    var isDisabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.setupUI()
        
    }
    
    
    @IBAction func loginButton_Action(_ sender: Any) {
        
        
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = UIColor.init(red: 0.072, green: 0.517, blue: 0.987, alpha: 1.0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        //Login Button Setup
        self.loginButton.backgroundColor = UIColor.init(red: 0.884, green: 0.168, blue: 0.595, alpha: 1.0)
        self.loginButton.layer.cornerRadius = 10
        self.buttonIsDisabled()
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //hideKeyboard()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.hideKeyboard()
        self.buttonIsDisabled()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideKeyboard()
        self.buttonIsDisabled()
        return true
    }
    
    func buttonIsDisabled() {
        if self.emailField.text != "" && self.passwordField.text != "" {
            self.isDisabled = false
            self.loginButton.layer.opacity = 1.0
        } else {
            self.isDisabled = true
            self.loginButton.layer.opacity = 0.65
        }
    }
}

