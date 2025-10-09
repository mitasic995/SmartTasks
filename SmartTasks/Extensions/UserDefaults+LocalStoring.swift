//
//  UserDefaults+LocalStoring.swift
//  SmartTasks
//
//  Created by Milos Tasic on 9. 10. 2025..
//

import Foundation

/// Just here as example of how we can use different data sources as local e.g `UserDefaults`as well or even implement DB.
extension UserDefaults: @unchecked @retroactive Sendable, LocalStoring {
    func readFrom(_ key: String) -> Data? {
        data(forKey: key)
    }
    
    func writeTo(_ key: String, data: Data) -> Bool {
        set(data, forKey: key)
        return true
    }
    
    func removeFrom(_ key: String) -> Bool {
        removeObject(forKey: key)
        return true
    }
}
