//
//  UserCell.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 3.09.2022.
//

import UIKit
class UserCell: UITableViewCell {
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemPurple
        imageView.clipsToBounds = true
        return imageView
    }()
    private let stackView = UIStackView()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Spiderman"
        return label
    }()
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .lightGray
        label.text = "Peter Parker"
        return label
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleCell()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension UserCell{
    private func styleCell(){
        //profileImageView Style
        profileImageView.layer.cornerRadius = 56 / 2
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        //stackView Style
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        //usernameLabel Style
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(usernameLabel)
        //fullnameLabel Style
        fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(fullnameLabel)
    }
    private func layout(){
        //profileImageView Layout
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 56),
            profileImageView.widthAnchor.constraint(equalToConstant: 56),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
        ])
    }
}
