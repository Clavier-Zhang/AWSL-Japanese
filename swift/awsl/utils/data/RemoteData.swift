//
//  utils.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Remote {
    
    // Address of your server
    static let baseURL = "<Your server address>/api"
    
    static func sendGetRequest(path: String, handleSuccess: @escaping (Data) -> Void, token: String, handleFail: Any = (), handleExit: Any = ()) -> Void {
        
        let url = URL(string: baseURL + path)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bearer "+token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if response.debugDescription.contains("403") {
                    if let handleFail = handleFail as? (_ text: String)->Void {
                        handleFail("403")
                    }
                } else {
                    handleSuccess(data)
                }
                
                return
            }
            
            if let handleFail = handleFail as? (_ text: String)->Void {
                handleFail(response.debugDescription)
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


