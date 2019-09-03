//
//  ChatsViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 9/3/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // MARK: IBActions
    @IBAction func createNewChatButtonPressed(_ sender: UIBarButtonItem) {
        let userVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersTableView") as! UserTableViewController
        self.navigationController?.pushViewController(userVC, animated: true)
    }
}
