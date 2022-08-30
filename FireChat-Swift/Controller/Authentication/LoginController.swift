//
//  LoginController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit
class LoginController: UIViewController {
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bubble.right")
        imageView.tintColor = .white
        return imageView
    }()
    private var stackView = UIStackView()
    
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
        button.isEnabled = false
        button.authButton()
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private let emailTextField =  CustomTextField(withPlaceHolder: "Email")
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(withPlaceHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have account?", attributes: [.foregroundColor : UIColor.white, .font : UIFont.preferredFont(forTextStyle: .body)])
        attributedTitle.append(NSAttributedString(string: " Sign Up", attributes: [
            .foregroundColor: UIColor.white,.font: UIFont.preferredFont(forTextStyle: .title2)
        ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
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
        stackView = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        //dontHaveAccountButton Style
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dontHaveAccountButton)
        //emailTextField, passwordTextField Style
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
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
        //dontHaveAccountButton Layout
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: dontHaveAccountButton.bottomAnchor),
            dontHaveAccountButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: dontHaveAccountButton.trailingAnchor, constant: 32)
        ])
    }
    
    func checkFormStatus()  {
        if viewModel.formIsValid{
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemPink
        }else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = .systemPink.withAlphaComponent(0.5)
        }
    }
    
}
// MARK: - Actions,Selectors
extension LoginController{
    @objc func handleShowSignUp(){
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func textDidChange(_ sender: UITextField){
        if sender == emailTextField {
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    @objc func handleLogin(_ sender: UIButton){
        
    }
}
