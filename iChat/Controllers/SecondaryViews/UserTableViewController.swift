//
//  UserTableViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 9/3/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAnalytics
import FirebaseDatabase
import FirebaseFirestore
import ProgressHUD

protocol ChatNetworking {
    func loadUsers(filter: String)
}

class UserTableViewController: UITableViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var allUsers: [FUser] = []
    var filteredUsers: [FUser] = []
    var allUsersGrouped = NSDictionary() as! [String: [FUser]]
    var sectionTitlesList: [String] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        tableView.tableFooterView = UIView()
        
        loadUsers(filter: Constants.CITY)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != nil {
            return 1
        } else {
            return allUsersGrouped.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != nil {
            return filteredUsers.count
        } else {
            let sectionTitle = self.sectionTitlesList[section]
            let users = self.allUsersGrouped[sectionTitle]
            
            return users!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuse, for: indexPath) as! UserTableViewCell
        
        var user: FUser
        if searchController.isActive && searchController.searchBar.text != nil {
            user = filteredUsers[indexPath.row]
        } else {
            let sectionTitle = self.sectionTitlesList[indexPath.section] // was row
            let users = self.allUsersGrouped[sectionTitle]
            
            user = users![indexPath.row]
        }
        
        cell.generateCell(fUser: user, indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive && searchController.searchBar.text != nil {
            return ""
        } else {
            return sectionTitlesList[section]
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searchController.isActive && searchController.searchBar.text != nil {
            return nil
        } else {
            return self.sectionTitlesList
        }
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var user: FUser
        if searchController.isActive && searchController.searchBar.text != nil {
            user = filteredUsers[indexPath.row]
        } else {
            let sectionTitle = self.sectionTitlesList[indexPath.section] // was row
            let users = self.allUsersGrouped[sectionTitle]
            
            user = users![indexPath.row]
        }
        
        startPrivateChat(user1: FUser.currentUser()!, user2: user)
    }
    
    // MARK: IBActions
    @IBAction func filterSegmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadUsers(filter: Constants.CITY)
        case 1:
            loadUsers(filter: Constants.COUNTRY)
        case 2:
            loadUsers(filter: "")
        default:
            return
        }
    }
    
    // MARK: Helper Functions
    fileprivate func splitDataIntoSections() {
        var sectionTitle: String = ""
        
        for i in 0..<self.allUsers.count {
            let currentUser = self.allUsers[i]
            let firstChar = currentUser.firstname.first!
            
            let firstCharString = "\(firstChar)".uppercased()
            
            if firstCharString != sectionTitle {
                sectionTitle = firstCharString
                self.allUsersGrouped[sectionTitle] = []
                self.sectionTitlesList.append(sectionTitle)
            }
            self.allUsersGrouped[firstCharString]?.append(currentUser)
        }
    }
}

extension UserTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentFor(text: text)
    }
    
    func filterContentFor(text: String, scope: String="All") {
        filteredUsers = allUsers.filter({ (user) -> Bool in
            return user.firstname.lowercased().contains(text.lowercased())
        })
        tableView.reloadData()
    }
}

extension UserTableViewController: ChatNetworking {
    func loadUsers(filter: String) {
        ProgressHUD.show()
        var query: Query!
        
        switch filter {
        case Constants.CITY:
            query = reference(.User).whereField(Constants.CITY, isEqualTo: FUser.currentUser()!.city).order(by: Constants.FIRSTNAME, descending: false)
        case Constants.COUNTRY:
            query = reference(.User).whereField(Constants.COUNTRY, isEqualTo: FUser.currentUser()!.city).order(by: Constants.FIRSTNAME, descending: false)
        default:
            query = reference(.User).order(by: Constants.FIRSTNAME, descending: false)
        }
        
        query.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                ProgressHUD.dismiss()
                return
            }
            
            self.allUsers = []
            self.sectionTitlesList = []
            self.allUsersGrouped = [:]
            
            if error != nil {
                print(error!.localizedDescription)
                ProgressHUD.dismiss()
                self.tableView.reloadData()
                return
            }
            
            if !snapshot.isEmpty {
                for userDict in snapshot.documents {
                    let userDict = userDict.data() as NSDictionary
                    let newUser = FUser(_dictionary: userDict)
                    
                    if newUser.objectId != FUser.currentId() {
                        self.allUsers.append(newUser)
                    }
                }
                self.splitDataIntoSections()
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
            ProgressHUD.dismiss()
        }
    }
}

extension UserTableViewController: UserTableViewCellDelegate {
    func didTapAvatarImage(indexPath: IndexPath) {
        let profileView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileView") as! ProfileViewTableViewController
        
        var user: FUser
        
        if searchController.isActive && searchController.searchBar.text != "" {
            user = filteredUsers[indexPath.row]
        } else {
            let sectionTitle = self.sectionTitlesList[indexPath.section]
            let users = self.allUsersGrouped[sectionTitle]
            user = users![indexPath.row]
        }
        
        profileView.user = user
        self.navigationController?.pushViewController(profileView, animated: true)
    }
}
