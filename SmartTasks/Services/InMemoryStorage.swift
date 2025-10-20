//
//  InMemoryStorage.swift
//  SmartTasks
//
//  Created by Milos Tasic on 9. 10. 2025..
//

import Foundation

/// In memory storage just for this testing puposes.
actor InMemoryStorage {
    private var cache: [String: Data]
    
    public init() {
        cache = [:]
    }
}

extension InMemoryStorage: LocalStoring {
    func readFrom(_ key: String) async -> Data? {
        guard let data = cache[key] else { return nil}
        return data
    }
    
    func writeTo(_ key: String, data: Data) async -> Bool {
        cache.updateValue(data, forKey: key)
        return true
    }
    
    func removeFrom(_ key: String) async -> Bool {
        cache.removeValue(forKey: key) != nil
    }
}
