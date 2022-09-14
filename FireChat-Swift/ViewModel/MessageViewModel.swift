//
//  MessageViewModel.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 7.09.2022.
//

import Foundation
import UIKit

struct MessageViewModel{
    
    private let message: Message
    var messageBackgroundColor: UIColor {
        return message.isFroCurrentUser ? .lightGray.withAlphaComponent(0.6) : .systemPurple
    }
    var messageTextColor: UIColor {
        return message.isFroCurrentUser ? .black : .white
    }
    var rightAnchorActive: Bool{
        return message.isFroCurrentUser
    }
    var leftAnchorActive: Bool{
        return !message.isFroCurrentUser
    }
    var shouldHideProfileImage: Bool{
        return message.isFroCurrentUser
    }
    init(message: Message) {
        self.message = message
    }
}
