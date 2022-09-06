//
//  ChatController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 6.09.2022.
//

import UIKit
class ChatController: UICollectionViewController {
    // MARK: - Properties
    private let user: User?
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
}
// MARK: - Helpers
extension ChatController{
    private func style(){
        collectionView.backgroundColor = .white
    }
}
