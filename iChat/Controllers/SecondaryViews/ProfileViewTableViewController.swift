//
//  ProfileViewTableViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 9/3/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit

class ProfileViewTableViewController: UITableViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var messageButtonOutlet: UIButton!
    @IBOutlet weak var callButtonOutlet: UIButton!
    @IBOutlet weak var blockButtonOutlet: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var user: FUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        setupUI()
    }
    
    // MARK: IBAction
    @IBAction func callButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func blockButtonPressed(_ sender: UIButton) {
        
        var currentBlockedIds = FUser.currentUser()!.blockedUsers
        
        if currentBlockedIds.contains(user!.objectId) {
            currentBlockedIds.remove(at: currentBlockedIds.firstIndex(of: user!.objectId)!)
        } else {
            currentBlockedIds.append(user!.objectId)
        }
        
        updateCurrentUserInFirestore(with: [Constants.BLOCKEDUSERID : currentBlockedIds]) { (error) in
            if error != nil {
                print("error \(error!.localizedDescription)")
                return
            }
            self.updateBlockStatus()
        }
    }
    
    
    // MARK: Setup UI
    func setupUI() {
        guard let user = user else {return}
        
        updateBlockStatus()
        
        self.title = "Profile"
        fullNameLabel.text = user.fullname.capitalized
        phoneNumberLabel.text = user.phoneNumber
        updateBlockStatus()
        imageFromData(pictureData: user.avatar) { (avatarImage) in
            if avatarImage != nil {
                self.avatarImageView.image = avatarImage!.circleMasked
            }
        }
    }
    
    func updateBlockStatus() {
        
        // If the user is looking at his own profile, hide the buttons else show the buttons
        let shouldBeHidden: Bool = !(user!.objectId != FUser.currentId())
        blockButtonOutlet.isHidden = shouldBeHidden
        messageButtonOutlet.isHidden = shouldBeHidden
        callButtonOutlet.isHidden = shouldBeHidden
        
        let blockTitle: String = (FUser.currentUser()!.blockedUsers.contains(user!.objectId)) ? "Unblock User" : "Block User"
        blockButtonOutlet.setTitle(blockTitle, for: .normal)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 30
    }
}
