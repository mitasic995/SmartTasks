//
//  LocalSourceMock.swift
//  SmartTasksTests
//
//  Created by Milos Tasic on 10. 10. 2025..
//

import Foundation
@testable import SmartTasks

actor LocalSourceMock: LocalStoring {
    private var stubData: Data?
    
    func stubData(_ data: Data) {
        stubData = data
    }
    
    var readFromCalled = false
    func readFrom(_ key: String) async -> Data? {
        readFromCalled = true
        return stubData
    }

    var writeToCalled = false
    func writeTo(_ key: String, data: Data) async -> Bool {
        writeToCalled = true
        return writeToCalled
    }
    
    var removeFromCalled = false
    func removeFrom(_ key: String) async -> Bool {
        removeFromCalled = true
        return removeFromCalled
    }
}
