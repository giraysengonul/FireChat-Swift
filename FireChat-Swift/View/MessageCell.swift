//
//  MessageCell.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 7.09.2022.
//

import UIKit
class MessageCell: UICollectionViewCell {
    // MARK: - Properties
    var message: Message?{
        didSet { configure() }
    }
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textColor = .white
        return textView
    }()
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
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
extension MessageCell{
    private func style(){
        //profileImage Style
        profileImage.layer.cornerRadius = 32 / 2
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImage)
        //bubbleContainer Style
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleContainer)
        //textView Style
        textView.translatesAutoresizingMaskIntoConstraints = false
        bubbleContainer.addSubview(textView)
    }
    private func layout(){
        //profileImage layout
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 4),
            profileImage.heightAnchor.constraint(equalToConstant: 32),
            profileImage.widthAnchor.constraint(equalToConstant: 32)
        ])
        //bubbleContainer Layout
        bubbleLeftAnchor = bubbleContainer.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        NSLayoutConstraint.activate([
            bubbleContainer.topAnchor.constraint(equalTo: topAnchor),
            bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
        //textView Layout
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: bubbleContainer.topAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: bubbleContainer.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: bubbleContainer.trailingAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: bubbleContainer.bottomAnchor, constant: -4)
        ])
    }
    func configure(){
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        profileImage.isHidden = viewModel.shouldHideProfileImage
        profileImage.sd_setImage(with: viewModel.profileImageUrl)
    }
}
