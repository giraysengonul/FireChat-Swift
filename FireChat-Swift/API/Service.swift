//
//  Service.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 4.09.2022.
//

import Foundation
import FirebaseFirestore

struct Service{
    
    static func fetchUsers(completion: @escaping([User]) -> Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
        
    }
    
}
