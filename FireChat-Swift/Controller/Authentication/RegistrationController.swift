//
//  RegistrationController.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 27.08.2022.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
class RegistrationController: UIViewController {
    // MARK: - Properties
    private var registrationViewModel = RegistrationViewModel()
    private var profileImage: UIImage?
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
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        style()
        layout()
        configureNotificationObservers()
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
    private func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
}

// MARK: - Actions , Selectors
extension RegistrationController{
    @objc func handleSelectPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    @objc func handleShowLogIn(){
        navigationController?.popViewController(animated: true)
    }
    @objc func textDidChange(_ sender: UITextField){
        if sender == emailTextField{
            registrationViewModel.email = sender.text
        }else if sender == passwordTextField{
            registrationViewModel.password = sender.text
        }else if sender == fullnameTextField{
            registrationViewModel.fullname = sender.text
        }else{
            registrationViewModel.username = sender.text
        }
        checkFormStatus()
    }
    @objc func handleRegistration(_ sender: UIButton){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let profileImage = profileImage else{ return }
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else{ return }
        let filename = UUID().uuidString
        let referance = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        referance.putData(imageData,metadata: nil) { metadata, error in
            if let error = error{
                print("Failed to upload image with error => \(error.localizedDescription)")
                return
            }
            referance.downloadURL { url, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                guard let profileImageUrl = url?.absoluteString else{ return }
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error{
                        print("Failed to create user with error => \(error.localizedDescription)")
                        return
                    }
                    guard let userId = result?.user.uid else { return }
                    let data = ["email": email, "fullname": fullname, "profileImageUrl": profileImageUrl, "uid": userId, "username": username] as [String: Any]
                    Firestore.firestore().collection("users").document("\(userId)").setData(data) { error in
                        if let error = error{
                            print("Failed to uplosf user data with error => \(error.localizedDescription)")
                            return
                        }
                        print("Did create user.")
                    }
                }
            }
        }
    }
}
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImage = image
            plusPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            plusPhotoButton.layer.cornerRadius = 120 / 2
            plusPhotoButton.layer.borderWidth = 3
            plusPhotoButton.clipsToBounds = true
            plusPhotoButton.layer.borderColor = UIColor.white.cgColor
            plusPhotoButton.contentMode = .scaleAspectFit
            dismiss(animated: true)
        }
    }
}
// MARK: - AuthenticationControllerProtocol
extension RegistrationController: AuthenticationControllerProtocol{
    
    func checkFormStatus(){
        if registrationViewModel.formIsValid{
            singUpButton.isEnabled = true
            singUpButton.backgroundColor = .systemPink
        }else{
            singUpButton.isEnabled = false
            singUpButton.backgroundColor = .systemPink.withAlphaComponent(0.5)
        }
    }
}
