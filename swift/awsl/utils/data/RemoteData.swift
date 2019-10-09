//
//  utils.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Remote {
    
    private static let baseURL = "http://192.168.31.158:8000/api"
    
    static private func sendGetRequest(path: String, handleSuccess: @escaping (Data) -> Void, token: String) -> Void {
        
        let url = URL(string: self.baseURL + path)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("bearer "+token, forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Status code not 200")
                return
            }
            // Handle success
            if let data = data{
                handleSuccess(data)
                return
            }
        }
                      
        task.resume()
        
    }
    
    
    static public func fetchHomeData(handleSuccess: @escaping (Data) -> Void) -> Void {
        
        let user : User? = Local.get(key: "user")
        
        if let user = user {
            
            SendGetRequest(path: "/user/home/"+user.email, handleSuccess: handleSuccess, token: user.token)
        } else {
            print("BUG: User not in local")
            return
        }
        
    }
    
    static public func fetchTask(handleSuccess: @escaping (Data) -> Void) -> Void {
        
        let user : User? = Local.get(key: "user")
        
        if let user = user {
            
            SendGetRequest(path: "/task/get/"+user.email, handleSuccess: handleSuccess, token: user.token)
        } else {
            print("BUG: User not in local")
            return
        }
        
    }
    
}


func SendPostRequest(path: String, data: Data, handleSuccess: @escaping (Data) -> Void) -> Void {
    
    // Create post request
    let url = URL(string: baseURL + path)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
    let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
        // Handle error
        if let error = error {
            return
        }
        // Handle error
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            return
        }
        // Handle success
        if let mimeType = response.mimeType, mimeType == "application/json", let data = data, let dataString = String(data: data, encoding: .utf8) {
            handleSuccess(data)
            return
        }
    }
                  
    task.resume()
    
}

func SendGetRequest(path: String, handleSuccess: @escaping (Data) -> Void, token: String) -> Void {
    
    // Create post request
    let url = URL(string: baseURL + path)!
    
    
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("bearer "+token, forHTTPHeaderField: "Authorization")
    
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle error
        if let error = error {
            print(error)
            return
        }
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("Status code not 200")
            return
        }
        // Handle success
        if let mimeType = response.mimeType, mimeType == "application/json", let data = data, let dataString = String(data: data, encoding: .utf8) {
            handleSuccess(data)
            return
        }
    }
                  
    task.resume()
    
}
