//
//  LoginViewModel.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 30.08.2022.
//

import Foundation

struct LoginViewModel{
    var email: String?
    var password: String?
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
