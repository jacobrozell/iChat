//
//  FinishRegistrationViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 8/5/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationViewController: UIViewController {
    
    //MARK: Variables
    var email: String!
    var password: String!
    var avatarImage: UIImage?
    
    //MARK: IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var countyTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    //MARK: Life-Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: UIActions
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        cleanTextFields()
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        ProgressHUD.show("Registering...", interaction: false)
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let _ = countyTextField.text, let _ = cityTextField.text, let _ = phoneTextField.text else {
            ProgressHUD.showError("All fields are required!")
            return
        }
        
        FUser.registerUserWith(email: email, password: password, firstName: firstName, lastName: lastName) { (error) in
            // Send to Messages
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            self.registerUser()
        }
    }
    
    //MARK: Helper Functions
    func registerUser() {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let county = countyTextField.text, let city = cityTextField.text, let phone = phoneTextField.text else { return }
        
        let fullName = "\(firstName) \(lastName)"
        var tempDict: Dictionary = [
            Constants.FIRSTNAME: firstName,
            Constants.LASTNAME: lastName,
            Constants.FULLNAME: fullName,
            Constants.COUNTRY: county,
            Constants.CITY: city,
            Constants.PHONE: phone
        ] as [String: Any]
        
        var avatar: String!
        if avatarImage == nil {
            imageFromInitials(firstName: firstName, lastName: lastName, withBlock: { (avatarInitials) in
                let avatarIMG = avatarInitials.jpegData(compressionQuality: 0.7)
                avatar = avatarIMG?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            })
            
        } else {
            let avatarData = avatarImage?.jpegData(compressionQuality: 0.7)
            avatar = avatarData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
        
        tempDict[Constants.AVATAR] = avatar
        
        
        // Finish Registration
        finishRegistration(with: tempDict)
        
    }
    
    func finishRegistration(with values: [String: Any]) {
        updateCurrentUserInFirestore(with: values) { (error) in
            if error != nil {
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                }
                return
            }
            // Go to App
            self.goToApp()
        }
    }
    
    func goToApp() {
        cleanTextFields()
        dismissKeyboard()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [Constants.USERID: FUser.currentId()])
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication")
        self.present(mainView, animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func cleanTextFields() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        countyTextField.text = ""
        cityTextField.text = ""
        phoneTextField.text = ""
    }
    
    

}
