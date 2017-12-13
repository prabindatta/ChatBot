//
//  CallbackChatBot.swift
//  ChatBot
//
//  Created by Prabin K Datta on 13/12/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import Foundation

protocol CallbackChatBot {
    func getChatBotList(
        begin: (() -> Void)?,
        success: ((_ result: ChatBotResult<ChatBot>) -> Void)?,
        error: ((_ statusCode: Int, _ errorResponse: ErrorResponse?) -> Void)?,
        complete: (() -> Void)?
    )
}
