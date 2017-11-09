//
//  CustomTextField.swift
//  BrightHR-Login
//
//  Created by Joshua Colley on 09/11/2017.
//  Copyright © 2017 Joshua Colley. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    var passwordVisible: Bool = false
    var button: UIButton?
    
    @IBInspectable var allowBottomLine: Bool = false {
        didSet {
            self.setBorder()
        }
    }
    
    @IBInspectable var placeholderUsed: Bool = false{
        didSet {
            self.setPlaceholderColor()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            self.setRHSImage()
        }
    }
    
    
    
    func setBorder() {
        if self.allowBottomLine {
            let border = CALayer()
            
            border.frame = CGRect.init(x: 0, y: frame.height - 2.0, width: frame.width, height: 2.0)
            border.backgroundColor = self.tintColor.cgColor
            
            self.layer.addSublayer(border)
        }
    }
    
    func setPlaceholderColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: self.tintColor])
    }
    
    func setRHSImage() {
        if let image = self.rightImage {
            self.rightViewMode = .always
            
            button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            button?.tintColor = self.tintColor
            button?.setImage(image, for: UIControlState.normal)
            button?.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
            let wrapperView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            wrapperView.addSubview(button!)
            
            self.rightView = wrapperView
        } else {
            self.rightViewMode = .never
        }
    }
    
    @objc func showPassword() {
        self.isSecureTextEntry = self.passwordVisible
        self.passwordVisible = !self.passwordVisible
        if passwordVisible {
            self.button?.tintColor = UIColor.white
        } else {
            self.button?.tintColor = self.tintColor
        }
    }
    

}
