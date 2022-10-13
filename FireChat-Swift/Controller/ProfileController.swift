//
//  ProfileController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 8.10.2022.
//

import UIKit
import FirebaseAuth
private let reuseIdentifier = "ProfileCell"
protocol ProfileControllerDelegate: AnyObject {
    func handleLogout()
}
class ProfileController: UITableViewController {
    // MARK: - Properties
    weak var delegate: ProfileControllerDelegate?
    private var user: User? {
        didSet{ headerView.user = user }
    }
    private lazy var headerView = ProfileHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 380))
    private let footerView = ProfileFooter()
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
        headerView.delegate = self
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
        footerView.delegate = self
    }
    private func layout(){
        
    }
}
// MARK: - Selectors
extension ProfileController{
    
}
// MARK: - UITableViewDataSource
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
// MARK: - UITableViewDelegate
extension ProfileController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewmodel = ProfileViewModel(rawValue: indexPath.row) else { return }
        switch viewmodel {
        case .accountInfo:
            print("a")
        case .settings:
            print("b")
        }
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
extension ProfileController: ProfileFooterDelegate{
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
