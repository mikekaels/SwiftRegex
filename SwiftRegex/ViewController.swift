//
//  ViewController.swift
//  SwiftRegex
//
//  Created by Santo Michael on 17/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let textfield: UITextField = {
        let t = UITextField()
        t.layer.borderColor = UIColor.systemGray.cgColor
        t.layer.cornerRadius = 7
        t.layer.borderWidth = 1
        t.layer.masksToBounds = true
        t.isSecureTextEntry = false
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let lblErrorMessage: UILabel = {
        let t = UILabel()
        t.textColor = .red
        t.numberOfLines = 0
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.delegate = self
        setupView()
    }
    
    func setupView() {
        view.addSubview(textfield)
        textfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textfield.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(lblErrorMessage)
        lblErrorMessage.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 4).isActive = true
        lblErrorMessage.leftAnchor.constraint(equalTo: textfield.leftAnchor).isActive = true
        lblErrorMessage.rightAnchor.constraint(equalTo: textfield.rightAnchor).isActive = true
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            validateText(text: text)
        }
    }
    
    func validateText(text: String) {
            // VALIDATE TEXT
        if text == "" {
            lblErrorMessage.text = nil
            textfield.layer.borderColor = UIColor.gray.cgColor
        } else if let errorMessage = text.validateText(constraints: [
            Regex.init(.numbers(), errorMessage: "At least 1 number"),
            Regex.init(.capitalLetters(), errorMessage: "At least 1 capital letters"),
            Regex.init(.minCharacters(min: 8), errorMessage: "Minimum 8 characters"),
            Regex.init(.specialCharacters(), errorMessage: "At least 1 special characters")
        ]) {
            lblErrorMessage.text = errorMessage.joined(separator: ", ")
            textfield.layer.borderColor = UIColor.red.cgColor
        } else {
            lblErrorMessage.text = nil
            textfield.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func validateURL(text: String) {
            //        VALIDATE URL
        if text == "" {
            lblErrorMessage.text = nil
            textfield.layer.borderColor = UIColor.gray.cgColor
        } else if let errorMessage = text.validateURL(errorMessage: "Url invalid") {
            lblErrorMessage.text = errorMessage
            textfield.layer.borderColor = UIColor.red.cgColor
        } else {
            lblErrorMessage.text = nil
            textfield.layer.borderColor = UIColor.green.cgColor
        }
    }
}
