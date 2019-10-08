//
//  utils.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation




func SendPostRequest(path: String, data: Data, handleSuccess: @escaping (Data) -> Void, handleError: @escaping () -> Void) -> Void {
    
    // Create post request
    let url = URL(string: baseURL + path)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
    let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
        // Handle error
        if let error = error {
            handleError()
            return
        }
        // Handle error
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            handleError()
            return
        }
        // Handle success
        if let mimeType = response.mimeType, mimeType == "application/json", let data = data, let dataString = String(data: data, encoding: .utf8) {
            handleSuccess(data)
            return
        }
        // Handle error
        handleError()
    }
                  
    task.resume()
    
}

func SendGetRequest(path: String, handleSuccess: @escaping (Data) -> Void, handleError: @escaping () -> Void) -> Void {
    
    // Create post request
    let url = URL(string: baseURL + path)!
    
    
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJUZXh0IjoiMjljOTE2ODUtY2RhYy00Zjc4LWI2OTQtMWQ1Nzg0NjExMDU1In0._oDtj7yZ-4jBI3wOS546rpOA9FKL8vvLk4gLIyvC4rM", forHTTPHeaderField: "Authorization")
    
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle error
        if let error = error {
            handleError()
            return
        }
        // Handle error
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            handleError()
            return
        }
        // Handle success
        if let mimeType = response.mimeType, mimeType == "application/json", let data = data, let dataString = String(data: data, encoding: .utf8) {
            handleSuccess(data)
            return
        }
        // Handle error
        handleError()
    }
                  
    task.resume()
    
}
