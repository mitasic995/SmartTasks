//
//  LocalStoring.swift
//  SmartTasks
//
//  Created by Milos Tasic on 9. 10. 2025..
//

import Foundation

protocol LocalStoring: Sendable {
    func readFrom(_ key: String) async -> Data?
    @discardableResult func writeTo(_ key: String, data: Data) async -> Bool
    @discardableResult func removeFrom(_ key: String) async -> Bool
}
