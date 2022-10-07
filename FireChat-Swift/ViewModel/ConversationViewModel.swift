//
//  ConversationViewModel.swift
//  FireChat-Swift
//
//  Created by hakkı can şengönül on 7.10.2022.
//

import Foundation

struct ConversationViewModel {
    private let conversation: Conversation
    
    var profileImageUrl: URL?{
        return URL(string: conversation.user.profileImageUrl)
    }
    
    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
