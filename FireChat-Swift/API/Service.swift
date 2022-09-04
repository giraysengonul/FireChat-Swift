//
//  Service.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 4.09.2022.
//

import Foundation
import FirebaseFirestore

struct Service{
    
    static func fetchUsers(){
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ snap in
                print(snap.data())
            })
        }
        
    }
    
}
