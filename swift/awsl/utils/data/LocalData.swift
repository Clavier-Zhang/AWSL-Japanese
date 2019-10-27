//
//  LocalData.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation



struct Local {
    
    private static let defaults = UserDefaults.standard
    
    // Save to local data by key
    public static func save<T: Encodable>(key: String, obj: T) {
        let data = objToData(obj: obj)
        defaults.set(data, forKey: key)
    }
    
    // Retrieve local data by key
    public static func get<T: Decodable>(key: String) -> T? {
        let data = defaults.data(forKey: key)
        if (data == nil) {
            return nil
        }
        let obj : T? = dataToObj(data: data!)
        return obj
    }
    
    // Remove local data by key
    public static func remove(key: String) {
        defaults.removeObject(forKey: key)
    }
    
    // Clean on local data
    public static func reset() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    public static func getTask() -> Task {
        let task: Task? = self.get(key: "task")
        if let task = task {
            return task
        }
        return Task(words: [Word](), date: 0)
    }
    
    public static func saveTask(task: Task) {
        self.save(key: "task", obj: task)
    }

}


func dataToObj<T: Decodable>(data: Data) -> T? {
    let res = try? JSONDecoder().decode(T.self, from: data)
    if let res = res {
        return res
    }
    return nil
}

// Always success
public func objToData<T: Encodable>(obj: T) -> Data {
    let data = try! JSONEncoder().encode(obj)
    return data
}
