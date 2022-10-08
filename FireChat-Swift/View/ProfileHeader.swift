//
//  ProfileHeader.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 8.10.2022.
//

import UIKit
protocol ProfileHeaderDelegate: AnyObject{
    func dismissController()
}
class ProfileHeader: UIView {
    var user: User? {
        didSet{ populateUserData() }
    }
    // MARK: - Properties
    weak var delegate: ProfileHeaderDelegate?
    private let gradient = CAGradientLayer()
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.imageView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 22).isActive = true
        return button
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private lazy var stack = UIStackView(arrangedSubviews: [fullnameLabel ,usernameLabel])
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
}
// MARK: - Helpers
extension ProfileHeader{
    private func style(){
        configureGradientLayer()
        //profileImageView style
        profileImageView.layer.cornerRadius = 200 / 2
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        //stack style
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        //dismissButton style
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dismissButton)
    }
    private func layout(){
        //profileImageView layout
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: topAnchor,constant: 96)
        ])
        //stack layout
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16)
        ])
        //dismissButton layout
        NSLayoutConstraint.activate([
            dismissButton.heightAnchor.constraint(equalToConstant: 48),
            dismissButton.widthAnchor.constraint(equalToConstant: 48),
            dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
    }
    private func configureGradientLayer(){
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        layer.addSublayer(gradient)
    }
    private func populateUserData(){
        guard let user = user else { return }
        guard let url = URL(string: user.profileImageUrl) else { return }
        fullnameLabel.text = user.fullname
        usernameLabel.text = "@" + user.username
        profileImageView.sd_setImage(with: url)
    }
}
// MARK: - Selectors
extension ProfileHeader{
    @objc func handleDismissal(_ sender: UIButton){
        delegate?.dismissController()
    }
}
