//
//  UdacitySessionRequest.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation

struct UdacitySessionRequest: Codable {
    let udacity: Udacity
}

struct Udacity: Codable {
    let password: String
    let username: String
}
