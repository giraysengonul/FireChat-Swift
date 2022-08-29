//
//  RegistrationController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit
class RegistrationController: UIViewController {
    // MARK: - Properties
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "plus_photo")
        button.tintColor = .white
        button.setImage(image, for:.normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    private var stackView = UIStackView()
    private lazy var emailContainerView : InputContainerView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        return InputContainerView(withImage: image, withTextField: emailTextField)
    }()
    private lazy var fullnameContainerView : InputContainerView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        return InputContainerView(withImage: image, withTextField: fullnameTextField)
    }()
    private lazy var usernameContainerView : InputContainerView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        return InputContainerView(withImage: image, withTextField: usernameTextField)
    }()
    private lazy var passwordContainerView : InputContainerView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        return InputContainerView(withImage: image, withTextField: passwordTextField)
    }()
    private let emailTextField =  CustomTextField(withPlaceHolder: "Email")
    private let fullnameTextField =  CustomTextField(withPlaceHolder: "Fullname")
    private let usernameTextField =  CustomTextField(withPlaceHolder: "Username")
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(withPlaceHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private let alredyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Alredy have account?", attributes: [.foregroundColor : UIColor.white, .font : UIFont.preferredFont(forTextStyle: .body)])
        attributedTitle.append(NSAttributedString(string: " Log In", attributes: [
            .foregroundColor: UIColor.white,.font: UIFont.preferredFont(forTextStyle: .title2)
        ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()
    private let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.authButton()
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        style()
        layout()
    }
}
// MARK: - Helpers
extension RegistrationController{
    private func style(){
        view.backgroundColor = .systemBlue
        //plusPhotoButton Style
        plusPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plusPhotoButton)
        //stackView Style
        stackView = UIStackView(arrangedSubviews: [emailContainerView,fullnameContainerView,usernameContainerView,passwordContainerView,singUpButton])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        //emailContainerView style
        emailContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //dontHaveAccountButton Style
        alredyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alredyHaveAccountButton)
    }
    private func layout(){
        //plusPhotoButton Layout
        NSLayoutConstraint.activate([
            plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            plusPhotoButton.heightAnchor.constraint(equalToConstant: 120),
            plusPhotoButton.widthAnchor.constraint(equalToConstant: 120),
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 32)
        ])
        //dontHaveAccountButton Layout
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: alredyHaveAccountButton.bottomAnchor),
            alredyHaveAccountButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: alredyHaveAccountButton.trailingAnchor, constant: 32)
        ])
    }
}

// MARK: - Actions , Selectors
extension RegistrationController{
    @objc func handleSelectPhoto(){
        
    }
    @objc func handleShowLogIn(){
        navigationController?.popViewController(animated: true)
    }
}
