//
//  RegistrationViewModel.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 1.09.2022.
//

import Foundation

protocol AuthenticationProtocol{
    var formIsValid: Bool { get }
}
struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
}
