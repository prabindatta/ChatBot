//
//  ChatBotResult.swift
//  ChatBot
//
//  Created by Prabin K Datta on 11/12/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import Foundation

class ChatBotResult<T> {
    
    var items: Array<T>
    //    var offset = 0
    //    var limit = 0
    //    var total = 0
    
    //    var nextOffset: Int? {
    //        get {
    //            let value = offset + limit
    //            return value < total ? value : nil
    //        }
    //    }
    
    init() {
        items = [T]()
    }
    
    init(items: Array<T>) {
        self.items = items
        //        self.offset = 0
        //        self.limit = items.count
        //        self.total = items.count
    }
    
    //    init(items: Array<T>, offset: Int, limit: Int, total: Int) {
    //        self.items = items
    //        self.offset = offset
    //        self.limit = limit
    //        self.total = total
    //    }
    
}
