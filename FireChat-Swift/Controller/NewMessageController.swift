//
//  NewMessageController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 3.09.2022.
//

import UIKit
private let reuseIdentifier = "UserCell"
protocol NewMessageControllerDelegate: AnyObject{
    func controller(_ controller: NewMessageController, wantsTostartChatWidth user: User)
}
class NewMessageController: UITableViewController {
    // MARK: - Properties
    private var users = [User]()
    private var filteredUsers = [User]()
    weak var delegate: NewMessageControllerDelegate?
    private let searchController = UISearchController(searchResultsController: nil)
    private var inSearchMode: Bool{
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
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
        configureSearchController()
        //tableView
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    private func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        definesPresentationContext = false
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField{
            textField.textColor = .systemPurple
            textField.backgroundColor = .white
        }
    }
}

// MARK: - API
extension NewMessageController{
    private func fetchUsers(){
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
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
        return inSearchMode ? filteredUsers.count : users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        delegate?.controller(self, wantsTostartChatWidth: user)
    }
}
// MARK: - UISearchResultsUpdating
extension NewMessageController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else{ return }
        filteredUsers = users.filter({ user in
            return user.username.contains(searchText) || user.fullname.contains(searchText)
        })
        self.tableView.reloadData()
    }
}
