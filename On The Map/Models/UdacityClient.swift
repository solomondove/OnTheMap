//
//  UdacityClient.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation
import UIKit

class UdacityClient: NSObject {
    
    
    static let udacityLogin = "{\"username\":\" \",\"password\":}"
    struct Auth {
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getSessionId
        case getStudentLocations
        
        var stringValue: String {
            switch self {
            case .getSessionId: return Endpoints.base + "/session"
            case .getStudentLocations: return Endpoints.base + "/StudentLocation?limit=100"
            }
            
            
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = UdacitySessionRequest(udacity: Udacity(password: password, username: username))
        ClientHelper.taskForPOSTRequest(url: Endpoints.getSessionId.url, responseType: UdacitySessionResponse.self, body: body) {(response, error) in
            if let response = response {
                UdacityClient.Auth.sessionId = response.session.sessionId
                print(UdacityClient.Auth.sessionId)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func getStudentLocations(completion: @escaping ([StudentLocation], Error?) -> Void)  {
        ClientHelper.taskForGETRequest(url: Endpoints.getStudentLocations.url, responseType: StudentLocationsResponse.self) {(response, error) in
            if let response = response {
                completion(response.studentLocations, nil)
            } else {
                completion([], error)
            }
        }
    }
    

}
