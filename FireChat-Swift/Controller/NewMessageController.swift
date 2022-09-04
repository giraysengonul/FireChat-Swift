//
//  NewMessageController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 3.09.2022.
//

import UIKit
private let reuseIdentifier = "UserCell"
class NewMessageController: UITableViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        fetchUsers()
        
    }
}
// MARK: - Helpers
extension NewMessageController{
    private func style(){
        //navigation
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        //tableView
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
}

// MARK: - API
extension NewMessageController{
    private func fetchUsers(){
        Service.fetchUsers()
    }
}

// MARK: - Actions, Selector
extension NewMessageController{
    @objc func handleDismissal(_ sender: UIBarButtonItem){
        dismiss(animated: true)
    }
}
extension NewMessageController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        return cell
    }
}
