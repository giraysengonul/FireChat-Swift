//
//  ProfileController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 8.10.2022.
//

import UIKit
import FirebaseAuth
private let reuseIdentifier = "ProfileCell"
class ProfileController: UITableViewController {
    // MARK: - Properties
    private var user: User? {
        didSet{ headerView.user = user }
    }
    private lazy var headerView = ProfileHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 380))
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tableView.contentInsetAdjustmentBehavior = .never
        navigationController?.navigationBar.barStyle = .black
    }
    // MARK: - API
    private func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
}
// MARK: - Helpers
extension ProfileController{
    private func style(){
        tableView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        headerView.delegate = self
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
    }
    private func layout(){
        
    }
}
// MARK: - Selectors
extension ProfileController{
    
}
extension ProfileController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath) as! ProfileCell
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
extension ProfileController: ProfileHeaderDelegate{
    func dismissController() {
        self.dismiss(animated: true)
    }
}
extension ProfileController{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
