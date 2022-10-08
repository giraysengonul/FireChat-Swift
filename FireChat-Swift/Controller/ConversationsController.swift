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
    private var conversations = [Conversation]()
    private lazy var newMessageButton: UIButton = {
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
        fetchConversations()
    }
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
    }
}

// MARK: - Helpers
extension ConversationsConroller{
    private func style(){
        view.backgroundColor = .white
        
        //navigationbar
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        //tableView
        tableView.backgroundColor = .white
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
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
    private func showChatController(forUser user: User){
        let chat = ChatController(user: user)
        chat.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(chat, animated: true)
    }
}
// MARK: - API
extension ConversationsConroller{
    func fetchConversations() {
        Service.fetchConversations { conversations in
            self.conversations = conversations
            self.tableView.reloadData()
        }
    }
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
        let controller = ProfileController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    @objc func showNewMessageController(_ sender:UIButton){
        DispatchQueue.main.async {
            let controller = NewMessageController()
            controller.delegate = self
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
        return conversations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
        
        
    }
}
// MARK: - NewMessageControllerDelegate
extension ConversationsConroller: NewMessageControllerDelegate{
    func controller(_ controller: NewMessageController, wantsTostartChatWidth user: User) {
        controller.dismiss(animated: true)
        showChatController(forUser: user)
    }
    
    
}
