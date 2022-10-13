//
//  ProfileFooter.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 8.10.2022.
//

import UIKit
protocol ProfileFooterDelegate: AnyObject{
    func handleLogout()
}

class ProfileFooter: UIView {
     // MARK: - Properties
    weak var delegate: ProfileFooterDelegate?
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
     // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 // MARK: - Helpers
extension ProfileFooter{
    private func style(){
        //logoutButton style
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoutButton)
    }
    private func layout(){
        //logoutButton layout
        NSLayoutConstraint.activate([
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            trailingAnchor.constraint(equalTo: logoutButton.trailingAnchor, constant: 32),
            logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
 // MARK: - Actions
extension ProfileFooter{
    @objc func handleLogout(_ sender: UIButton){
        delegate?.handleLogout()
    }
}
