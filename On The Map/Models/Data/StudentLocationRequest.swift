//
//  StudentPostRequest.swift
//  On The Map
//
//  Created by Solomon Dove on 2/18/22.
//

import Foundation

struct StudentLocationRequest: Codable {
    let uniqueKey: String
    let lastName: String
    let firstName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
