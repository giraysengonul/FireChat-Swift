//
//  InputContainerView.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 28.08.2022.
//

import UIKit
class InputContainerView: UIView {
    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    private var textField = UITextField()
    private let dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        return dividerView
    }()
    
    
    init(withImage image: UIImage, withTextField textField: UITextField) {
        self.textField = textField
        self.imageView.image = image
        super.init(frame: .zero)
        style()
        layout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension InputContainerView{
    private func style(){
        //imageView Style
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        //textField Style
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        //dividerView Style
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dividerView)
    }
    private func layout(){
        
        //imageViewLayout
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 24),
        ])
        //textField Layout
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
        ])
        //dividerView Layout
        NSLayoutConstraint.activate([
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.75),
            
        ])
    }
}
