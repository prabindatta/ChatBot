//
//  Client.swift
//  ChatBot
//
//  Created by Prabin K Datta on 13/12/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import Foundation

class Client {
    class func chatBot() -> CallbackChatBot {
        if Environment.instance().mocked {
            return ChatBotMockImp()
        } else {
            return ChatBotNetworkImp()
        }
    }
}
