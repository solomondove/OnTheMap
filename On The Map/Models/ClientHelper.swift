//
//  ClientHelper.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation

class ClientHelper {
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async{
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let responseObject: ResponseType
            do {
                let range = (5..<data.count)
                let newData = data.subdata(in: range) /* subset response data! */
                responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async{
                    completion(responseObject, nil)
                }
            } catch {
//                do {
//                    let errorResponse = try decoder.decode(TMDBResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
//                    DispatchQueue.main.async{
//                        completion(nil, error)
//                    }
//                }
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                DispatchQueue.main.async{
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let responseObject: ResponseType
            do {
                responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async{
                    completion(responseObject, nil)
                }
            } catch {
//                do {
//                    let errorResponse = try decoder.decode(TMDBResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
                    DispatchQueue.main.async{
                        completion(nil, error)
                    }
//                }

            }
        }
        task.resume()
    }
}
