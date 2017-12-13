//
//  Chatbot.swift
//  ChatBot
//
//  Created by Prabin K Datta on 11/12/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import Foundation

class ChatBot {
    struct Answer {
        var answer: String
        var childCode: NSInteger
    }
    var chatbotCode: NSInteger
    var chatbotQues: String
    var chatbotAnswers: Array<Answer>
    
    init(code:NSInteger, ques: String, ans: Array<Answer>) {
        self.chatbotCode = code
        self.chatbotQues = ques
        self.chatbotAnswers = ans
    }
}
