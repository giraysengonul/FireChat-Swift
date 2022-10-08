//
//  ProfileCell.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 8.10.2022.
//

import UIKit

class ProfileCell: UITableViewCell {
    // MARK: - Properties
    var viewModel: ProfileViewModel? {
        didSet{configure() }
    }
    private lazy var iconView: UIView = {
        let imageView = UIView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemPurple
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.layer.cornerRadius = 40 / 2
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(iconImage)
        iconImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        return imageView
    }()
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private lazy var stackView = UIStackView(arrangedSubviews: [iconView, titleLabel])
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
extension ProfileCell{
    private func setup(){
        //stackView setup
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        addSubview(stackView)
    }
    private func  layout(){
        //stackView layout
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12)
        ])
    }
    private func configure(){
        guard let viewModel = viewModel else { return }
        iconImage.image = UIImage(systemName: viewModel.iconImageName)
        titleLabel.text = viewModel.description
    }
    
}
