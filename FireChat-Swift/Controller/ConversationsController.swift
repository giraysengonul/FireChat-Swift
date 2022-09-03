//
//  ConversationsController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit
import FirebaseAuth
private let reuseIdentifier = "ConversationCell"
class ConversationsConroller: UIViewController {
    // MARK: - properties
    private let tableView = UITableView()
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(showNewMessageController), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        authenticateUser()
    }
}

// MARK: - Helpers
extension ConversationsConroller{
    private func style(){
        view.backgroundColor = .white
        configureNavigationBar()
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        //tableView
        tableView.backgroundColor = .white
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        //newMessageButton Style
        newMessageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newMessageButton)
        
        
    }
    private func layout(){
        //newMessageButton Layout
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: newMessageButton.bottomAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: newMessageButton.trailingAnchor, constant: 24),
            newMessageButton.heightAnchor.constraint(equalToConstant: 56),
            newMessageButton.widthAnchor.constraint(equalToConstant: 56)
        ])
    }
    private func configureNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.backgroundColor = .systemPurple
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        navigationController?.navigationBar.barStyle = .black
    }
}
// MARK: - API
extension ConversationsConroller{
    func authenticateUser()  {
        if Auth.auth().currentUser?.uid == nil{
            presentLoginScreen()
            return
        }
    }
    func logout(){
        do{
            try Auth.auth().signOut()
            presentLoginScreen()
        }catch{
            print("Error signing out.")
        }
    }
    func presentLoginScreen(){
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
}
// MARK: - Actions, Selector
extension ConversationsConroller{
    @objc func showProfile(_ sender: UIBarButtonItem){
        logout()
    }
    @objc func showNewMessageController(_ sender:UIButton){
        DispatchQueue.main.async {
            let controller = NewMessageController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension ConversationsConroller : UITableViewDelegate
,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Cell"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
