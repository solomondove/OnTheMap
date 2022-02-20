//
//  StudentLocation.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation
import MapKit

struct StudentLocation: Codable {
    let objectId: String
    let uniqueKey: String
    let lastName: String
    let firstName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let updatedAt: String
    let createdAt: String
}
