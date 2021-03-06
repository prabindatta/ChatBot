//
//  Environment.swift
//  ChatBot
//
//  Created by Prabin K Datta on 08/12/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import Foundation

struct Environment: Equatable, CustomStringConvertible {
    var name: String
    var scheme: String
    var domain: String
    var port: Int?
    var context: String
    var mocked: Bool
    
    static let MOCK = Environment(
        name:                               "MOCK",
        scheme:                             "",
        domain:                             "",
        port:                               nil,
        context:                            "",
        mocked:                             true
    )
    static let PROD = Environment(
        name:                               "PROD",
        scheme:                             "http",
        domain:                             "country.io",
        port:                               nil,
        context:                            "",
        mocked:                             false
    )
    
    //MARK: Confirm to Equatable
    static func ==(lhs: Environment, rhs: Environment) -> Bool {
        return lhs.name == rhs.name
    }
    
    //MARK: Confirm to CustomStringConvertible
    var description: String {
        return self.name
    }
    
    init(name: String,
         scheme: String,
         domain: String,
         port: Int?,
         context: String,
         mocked: Bool
        ) {
        self.name = name
        self.scheme = scheme
        self.domain = domain
        self.port = port
        self.context = context
        self.mocked = mocked
    }
    
    static func instance() -> Environment {
        let prefs = UserDefaults.standard
        let value = prefs.object(forKey: Constants.ENVIRONMENT) as? String
        if value == nil || value == Environment.MOCK.name {
            return Environment.MOCK
        }
        return Environment.PROD
    }
    
    var baseUrl: String {
        get {
            if domain != "" {
                let portString = port != nil ? ":\(port!)" : ""
                return "\(scheme)://\(domain)\(portString)"
            }
            return ""
        }
    }
    
    var baseUrlWithContext: String {
        get {
            return baseUrl + context
        }
    }
}
