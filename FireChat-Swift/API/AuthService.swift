//
//  AuthService.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 3.09.2022.
//

import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import UIKit

struct RegistrationCredentials{
    var email: String
    var password: String
    var fullname: String
    var username: String
    var profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    func logUserIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    func createUser(credentials: RegistrationCredentials, completion: @escaping(Error?)->Void){
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else{ return }
        let filename = UUID().uuidString
        let referance = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        referance.putData(imageData,metadata: nil) { metadata, error in
            if let error = error{
                completion(error)
                return
            }
            referance.downloadURL { url, error in
                if let error = error {
                    completion(error)
                    return
                }
                guard let profileImageUrl = url?.absoluteString else{ return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                    if let error = error{
                        completion(error)
                        return
                    }
                    guard let userId = result?.user.uid else { return }
                    let data = ["email": credentials.email, "fullname": credentials.fullname, "profileImageUrl": profileImageUrl, "uid": userId, "username": credentials.username] as [String: Any]
                    Firestore.firestore().collection("users").document("\(userId)").setData(data, completion: completion)
                }
            }
        }
    }
}
