//
//  utils.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Remote {
    
//    DEV
    static let baseURL = "http://47.89.243.163:8000/api"
    
    static let baseURL = "http://192.168.31.158:8000/api"
    
    static func sendGetRequest(path: String, handleSuccess: @escaping (Data) -> Void, token: String, handleFail: Any = ()) -> Void {
        
        let url = URL(string: baseURL + path)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bearer "+token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                handleSuccess(data)
                return
            } else {
                if let handleFail = handleFail as? ()->Void {
                    handleFail()
                }
                print("ERROR: Request failed")
            }
            
        }
                      
        task.resume()
        
    }
    
    static func sendPostRequest(path: String, data: Data, handleSuccess: @escaping (Data) -> Void, token: String = "", handleFail: Any = ()) -> Void {
        
        // Create post request
        let url = URL(string: baseURL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("bearer "+token, forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
            if let data = data {
                handleSuccess(data)
                return
            } else {
                if let handleFail = handleFail as? ()->Void {
                    handleFail()
                }
                print("ERROR: Request failed")
            }
        }
                      
        task.resume()
        
    }
    
    
}


