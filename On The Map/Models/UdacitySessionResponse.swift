//
//  SessionResponse.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation

struct UdacitySessionResponse: Codable {
    let account: Account
    let session: Session
    
    enum CodingKeys: String, CodingKey {
        case account
        case session
    }
}

struct Session: Codable {
    let sessionId: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "id"
        case expiration
    }
}

struct Account: Codable {
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered = "registered"
        case key = "key"
    }
}
