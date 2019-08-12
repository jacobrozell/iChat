//
//  SettingsTableViewController.swift
//  iChat
//
//  Created by Jacob Rozell on 8/12/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    // MARK: IBActions
    @IBAction func logOutPressed(_ sender: UIButton) {
        FUser.logOutCurrentUser { (success) in
            if success {
                self.showLoginView()
            }
        }
    }
    
    func showLoginView() {
        let welcomeView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome")
        self.present(welcomeView, animated: true, completion: nil)
    }
}
