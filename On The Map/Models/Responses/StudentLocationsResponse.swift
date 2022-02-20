//
//  StudentLocationsResponse.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation
struct StudentLocationsResponse: Codable {
    let studentLocations: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case studentLocations = "results"
    }
}
