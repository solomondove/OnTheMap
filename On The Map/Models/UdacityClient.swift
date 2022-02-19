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
        case postStudentLocation
        
        var stringValue: String {
            switch self {
            case .getSessionId: return Endpoints.base + "/session"
            case .getStudentLocations: return Endpoints.base + "/StudentLocation?limit=100&order=-updatedAt"
            case .postStudentLocation: return Endpoints.base + "/StudentLocation"
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
    
    class func logout(){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil { // Handle error…
              return
          }
          let range = (5..<data!.count)
          let newData = data?.subdata(in: range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func postStudentLocation(lastName: String, firstName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completion: @escaping(Bool, Error?) -> Void) {
        let body = StudentLocationRequest(uniqueKey: self.randomString(length: 10), lastName: lastName, firstName: firstName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)
        ClientHelper.taskForPOSTRequest(url: Endpoints.postStudentLocation.url, responseType: StudentLocationResponse.self, body: body) {(response, error) in
            if let response = response {
                print(response)
                completion(true, nil)
            } else {
                completion(false, error)
            }
            
        }
    }
    
    class func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
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
