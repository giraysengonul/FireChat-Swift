//
//  Message.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 7.09.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
struct Message{
    let text: String
    let toId: String
    let fromId: String
    var timestamp: Timestamp!
    var user: User?
    let isFroCurrentUser: Bool
    
    init(dictionary: [String : Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.isFroCurrentUser = fromId == Auth.auth().currentUser?.uid
        
    }
}
