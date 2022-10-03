//
//  ChatController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 6.09.2022.
//

import UIKit
private let reuseIdentifier = "MessageCell"
class ChatController: UICollectionViewController {
    // MARK: - Properties
    private let user: User
    private var messages = [Message]()
    var fromCurrentUser = false
    private lazy var customInputView: CustomInputAccessoryView = {
        let view = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        view.delegate = self
        return view
    }()
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        fetchMessage()
    }
    override var inputAccessoryView: UIView?{
        get { return customInputView }
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
// MARK: - API
extension ChatController{
    func fetchMessage() {
        Service.fetchMessages(forUser: user) { messages in
            self.messages = messages
            self.collectionView.reloadData()
            
        }
    }
}
// MARK: - Helpers
extension ChatController{
    private func style(){
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        
    }
}
extension ChatController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
}
extension ChatController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}
extension ChatController: CustomInputAccessoryViewDelegate{
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSende message: String) {
        Service.uploadMessage(message, to: user) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            inputView.clearMessageText()
        }
    }
    
    
}
