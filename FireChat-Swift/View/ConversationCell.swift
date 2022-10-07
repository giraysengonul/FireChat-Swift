//
//  ConversationCell.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 7.10.2022.
//

import UIKit

class ConversationCell: UITableViewCell {
    // MARK: - Properties
    var conversation: Conversation? {
        didSet{ configure() }
    }
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 50 / 2
        return imageView
    }()
    private let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "2h"
        return label
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let stackView = UIStackView()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Helpers
extension ConversationCell{
    private func setup(){
        //profileImageView setup
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        //stackView setup
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        //usernameLabel And messagetextLabel setup
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        messageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(messageTextLabel)
        //timestampLabel setup
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timestampLabel)
        
    }
    private func layout(){
        //profileImageView layout
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        //stackView layout
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16)
        ])
        //timestampLabel layout
        NSLayoutConstraint.activate([
            timestampLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            trailingAnchor.constraint(equalTo: timestampLabel.trailingAnchor, constant: 12)
        ])
    }
    private func configure(){
        guard let conversation = conversation else{ return }
        let viewModel = ConversationViewModel(conversation: conversation)
        usernameLabel.text = conversation.user.username
        messageTextLabel.text = conversation.message.text
        timestampLabel.text = viewModel.timestamp
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
