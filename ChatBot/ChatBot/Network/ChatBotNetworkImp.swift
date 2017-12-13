//
//  ChatBotNetworkImp.swift
//  ChatBot
//
//  Created by Prabin K Datta on 11/12/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChatBotNetworkImp : CallbackChatBot {
    func getChatBotList(
        begin: (() -> Void)?,
        success: ((_ result: ChatBotResult<ChatBot>) -> Void)?,
        error: ((_ statusCode: Int, _ errorResponse: ErrorResponse?) -> Void)?,
        complete: (() -> Void)?
        ){
        
        Network.GET(uri: "/names.json",
                    parameters: nil,
                    authorization: "",
                    cacheEnabled: true,
                    begin: begin,
                    success: { (responseObject, headers) -> Void in
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                            guard let responseDictionary = responseObject as? NSDictionary else {
                                error?(410, nil)
                                return
                            }
                            
                            var localDictionary: String?
                            if let path = Bundle.main.path(forResource: "", ofType: "json") {
                                do {
                                    try localDictionary = String(contentsOfFile: path)
                                }
                                catch {
                                    print(error)
                                }
                                
                                
                            }
//                            let json = JSON(parseJSON:  responseDictionary)
                            let json = JSON(parseJSON:  localDictionary!)
                            let result = ChatBotResult<ChatBot>()
                            for  itemJson in json.array! {
                                //---
                                var code: NSInteger?
                                var question: String?
                                var answers: Array<ChatBot.Answer>?
                                for (key, value) : (String, JSON) in itemJson.dictionary! {
                                    switch key {
                                    case "code" :
                                        code = value.intValue
                                    case "question" :
                                        question = value.string
                                    case "answers" :
                                        answers = Array<ChatBot.Answer>()
                                        
                                        for ans in value.array! {
                                            var child: NSInteger?
                                            var answer: String?
                                            for (anskey, ansvalue) : (String, JSON) in ans {
                                                switch anskey {
                                                case "child" :
                                                    child = ansvalue.intValue
                                                case "ans" :
                                                    answer = ansvalue.string
                                                default:
                                                    print("Unknown Key")
                                                }
                                            }
                                            let answerItem: ChatBot.Answer = ChatBot.Answer(answer: answer! , childCode: child! )
                                            answers?.append(answerItem)
                                        }
                                        print("Answer Key \(answers)")
                                    default :
                                        print("Unknown Key")
                                    }
                                }

                                result.items += [ChatBot.init(code: code!, ques: question! , ans: answers!)]

                            }
                            success?(result)
                            
                        }
        },
                    error: { (lerror, statusCode, headers, responseObject) -> Void in
                        self.handleError(lerror: lerror, statusCode: statusCode, headers: headers, responseObject: responseObject, error: error)
        },
                    complete: complete
        )
    }
    
    func handleError(
        lerror: Error,
        statusCode: Int,
        headers: [AnyHashable: Any]?,
        responseObject: AnyObject?,
        error: ((_ statusCode: Int,_ errorResponse: ErrorResponse?) -> Void)?) {
        if let responseDictionary = responseObject as? NSDictionary {
            let json = JSON(responseDictionary)
            let errorResponse = ErrorResponse(error: lerror, statusCode: statusCode, headers: headers, json: json)
            error?(statusCode, errorResponse)
        } else {
            let errorResponse = ErrorResponse(error: lerror, statusCode: statusCode, headers: headers, json: nil)
            error?(statusCode, errorResponse)
        }
    }
}
