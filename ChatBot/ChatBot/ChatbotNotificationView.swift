//
//  ChatbotNotificationViewController.swift
//  ChatBot
//
//  Created by Prabin K Datta on 30/11/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import UIKit

class ChatbotNotificationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ChatbotNotificationView", owner: self, options: nil)
        addSubview(<#T##view: UIView##UIView#>)
    }
}
