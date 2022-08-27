//
//  ConversationsController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit

class ConversationsConroller: UIViewController {
    // MARK: - properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

// MARK: - Helpers
extension ConversationsConroller{
    private func style(){
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
    }
    private func layout(){
        
    }
}
 // MARK: - Actions
extension ConversationsConroller{
    @objc func showProfile(){
        
    }
}
