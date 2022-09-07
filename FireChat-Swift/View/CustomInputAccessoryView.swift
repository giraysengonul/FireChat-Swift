//
//  CustomInputAccessoryView.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 6.09.2022.
//

import UIKit
protocol CustomInputAccessoryViewDelegate: AnyObject{
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSende message: String)
}
class CustomInputAccessoryView: UIView {
    // MARK: - Properties
    weak var delegate: CustomInputAccessoryViewDelegate?
    let messageInputTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        return textView
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
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
    override var intrinsicContentSize: CGSize{
        return .zero
    }
}
// MARK: - Helpers
extension CustomInputAccessoryView{
    private func style(){
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = .init(width: 0, height: -8)
        //sendButton Style
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sendButton)
        //messageInputTextView Style
        messageInputTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageInputTextView)
        //placeHolderLabel Style
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeHolderLabel)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    private func layout(){
        //sendButton Layout
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: 8),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        //messageInputTextView Layout
        NSLayoutConstraint.activate([
            messageInputTextView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageInputTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: messageInputTextView.bottomAnchor, constant: 8),
            sendButton.leadingAnchor.constraint(equalTo: messageInputTextView.trailingAnchor, constant: 8),
        ])
        //placeHolderLabel Layout
        NSLayoutConstraint.activate([
            placeHolderLabel.leadingAnchor.constraint(equalTo: messageInputTextView.leadingAnchor, constant: 4),
            placeHolderLabel.centerYAnchor.constraint(equalTo: messageInputTextView.centerYAnchor)
        ])
    }
}
// MARK: - Action, Selector
extension CustomInputAccessoryView{
    @objc func handleSendMessage(_ sender: UIButton){
        guard let message = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSende: message)
    }
    @objc func handleTextInputChange(){
        placeHolderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
}
