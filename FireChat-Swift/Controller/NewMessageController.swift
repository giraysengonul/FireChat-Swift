//
//  NewMessageController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 3.09.2022.
//

import UIKit

class NewMessageController: UITableViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
}
// MARK: - Helpers
extension NewMessageController{
    private func style(){
        view.backgroundColor = .red
    }
}
