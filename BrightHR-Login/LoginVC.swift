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
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private let serverURL = URL(string: "https://brighthr-api-uat.azurewebsites.net/api/Account/PostValidateUser")!
    
    private let response403 = "Please enter a valid username and password."
    private let response200 = "Welcome to Europe/London."
    private let responseDefault = "Sorry, something has gone wrong. Please try again."
    
    var isDisabled = true
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.setupUI()
        
    }
    
    
    @IBAction func loginButton_Action(_ sender: Any) {
        if !isDisabled {
            self.loginButton.setTitle("", for: .normal)
            self.activityIndicator.startAnimating()
            print(self.dataRequest(self.serverURL) as Any)
        }
    }
    
    
    func dataRequest(_ url:URL) -> Error?{
        var recievedResponse: HTTPURLResponse!
        var recievedError: Error?
        
        let parameterString = "username=\(self.emailField.text!)&password=\(self.passwordField.text!)"
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = parameterString.data(using: .utf8)
        
        let task = session.dataTask(with: request as URLRequest) {data,response,error in
            if error == nil {
                recievedResponse = response as! HTTPURLResponse
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.loginButton.setTitle("Login", for: .normal)
                    self.handleResponse(response: recievedResponse)
                }
            } else {
                recievedError = error
            }
        }
        task.resume()
        
        return recievedError
    }
    
    
    func handleResponse(response: HTTPURLResponse) {
        switch response.statusCode {
        case 403:
            self.responseLabel.text = self.response403
            break
        case 200:
            self.responseLabel.text = self.response200
            let dateString = response.allHeaderFields["Date"] as! String
            self.timezoneLabel.text = "User's Timezone: \(self.getTimezone(dateString: dateString))"
            break
        default:
            self.responseLabel.text = self.responseDefault
            break
        }
    }
    
    
    func getTimezone(dateString: String) -> String {
        let timezone = String(dateString.suffix(from: String.Index.init(encodedOffset: dateString.count-3)))
        return timezone
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
}

