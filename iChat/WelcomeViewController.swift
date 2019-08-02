//
//  WelcomeViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 7/29/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    //MARK: IBActions
    @IBAction func loginPressed(_ sender: Any) {
        dismissKeyboard()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        dismissKeyboard()
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeyboard()
    }
    
    
    //MARK: Helper Functions
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func cleanTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextfield.text = ""
    }
}
