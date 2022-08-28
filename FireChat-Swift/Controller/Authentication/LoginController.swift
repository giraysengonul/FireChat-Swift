//
//  LoginController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit
class LoginController: UIViewController {
    // MARK: - Properties
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bubble.right")
        imageView.tintColor = .white
        return imageView
    }()
    private let stackView = UIStackView()
    
    private lazy var emailContainerView : InputContainerView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        return InputContainerView(withImage: image, withTextField: emailTextField)
    }()
    private lazy var passwordContainerView : InputContainerView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        return InputContainerView(withImage: image, withTextField: passwordTextField)
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemPink.withAlphaComponent(0.5)
        return button
    }()
    private let emailTextField =  CustomTextField(withPlaceHolder: "Email")
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(withPlaceHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}
// MARK: - Helpers
extension LoginController{
    private func style(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        //iconImage Style
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconImage)
        //stackView Style
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        //emailcontainer Style
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(emailContainerView)
        //passwordcontainer Style
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(passwordContainerView)
        //loginButton Style
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(loginButton)
    }
    private func layout(){
        //iconImage Layout
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 120),
            iconImage.widthAnchor.constraint(equalToConstant: 120),
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 32)
        ])
        //emailcontainer Layout
        emailContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.frame = view.frame
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
    }
}
