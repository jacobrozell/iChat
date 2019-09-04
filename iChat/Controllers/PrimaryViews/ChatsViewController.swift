//
//  ChatsViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 9/3/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var recentChats: [NSDictionary] = []
    var filteredChats: [NSDictionary] = []
    var recentListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadRecentChats()
    }
    
    
    // MARK: IBActions
    @IBAction func createNewChatButtonPressed(_ sender: UIBarButtonItem) {
        let userVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersTableView") as! UserTableViewController
        self.navigationController?.pushViewController(userVC, animated: true)
    }
    
    
    // MARK: Load Recent Chats
    func loadRecentChats() {
        
        recentListener = reference(.Recent)
            .whereField(Constants.USERID, isEqualTo: FUser.currentId())
            .addSnapshotListener({ (snapshot, error) in
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty {
                    let sorted = ((dictionaryFromSnapshots(snapshots: snapshot.documents)) as NSArray)
                        .sortedArray(using: [NSSortDescriptor(key: Constants.DATE, ascending: false)]) as! [NSDictionary]
                    
                    for recent in sorted {
                        if recent[Constants.LASTMESSAGE] as! String != "" && recent[Constants.CHATROOMID] != nil && recent[Constants.RECENTID] != nil {
                            self.recentChats.append(recent)
                        }
                    }
                    self.tableView.reloadData()
                }
            })
    }
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentChatTableViewCell.reuse, for: indexPath) as! RecentChatTableViewCell
        
        cell.generateCell(recentChat: recentChats[indexPath.row], indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
