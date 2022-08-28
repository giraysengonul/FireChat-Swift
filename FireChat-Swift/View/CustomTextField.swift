//
//  CustomTextField.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 28.08.2022.
//

import UIKit
class CustomTextField: UITextField {
    var placeHolders: String
    init(withPlaceHolder placeHolder: String) {
        placeHolders = placeHolder
        super.init(frame: .zero)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension CustomTextField{
    private func style(){
        attributedPlaceholder = NSAttributedString(string: placeHolders, attributes: [.foregroundColor : UIColor.white])
        keyboardAppearance = .dark
        textColor = .white
        borderStyle = .none
        font = UIFont.preferredFont(forTextStyle: .body)
        
    }
}
