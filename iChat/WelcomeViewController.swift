//
//  WelcomeViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 7/29/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

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
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            
            ProgressHUD.showError("Email/Password field is empty!")
            return
        }
        
        FUser.loginUserWith(email: email, password: password) { (error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.goToApp()
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        dismissKeyboard()
        if emailTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextfield.text == "" {
            ProgressHUD.showError("All fields are required!")
            return
        }
        
        if passwordTextField.text == confirmPasswordTextfield.text {
            registerUser()
        } else {
            ProgressHUD.showError("Passwords must match!")
            cleanTextFields()
        }
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
    
    //MARK: GoToApp
    func goToApp() {
        ProgressHUD.dismiss()
        cleanTextFields()
        dismissKeyboard()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [Constants.USERID: FUser.currentId()])
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication")
        self.present(mainView, animated: true, completion: nil)
    }
    
    func registerUser() {
        performSegue(withIdentifier: "welcomeToCompleteRegister", sender: self)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welcomeToCompleteRegister" {
            let vc = segue.destination as! FinishRegistrationViewController
            vc.email = emailTextField.text!
            vc.password = passwordTextField.text!
            
            cleanTextFields()
            dismissKeyboard()
        }
    }
}
