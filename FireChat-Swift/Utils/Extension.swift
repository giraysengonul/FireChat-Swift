//
//  Extension.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 29.08.2022.
//

import UIKit
import JGProgressHUD
extension UIViewController{
    static let hud = JGProgressHUD(style: .dark)
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor , UIColor.systemPink.cgColor]
        gradient.locations = [0,1]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
    }
    func showLoader(_ show: Bool,withText text: String? = "Loading"){
        view.endEditing(true)
        UIViewController.hud.textLabel.text = text
        show ? UIViewController.hud.show(in: view, animated: true) : UIViewController.hud.dismiss(animated: true)
    }
    
    func configureNavigationBar(withTitle title: String, prefersLargeTitles: Bool){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.backgroundColor = .systemPurple
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        navigationController?.navigationBar.barStyle = .black
    }
}
extension UIButton{
    func authButton(){
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        tintColor = .white
        layer.cornerRadius = 5
        backgroundColor = .systemPink.withAlphaComponent(0.5)
    }
}
