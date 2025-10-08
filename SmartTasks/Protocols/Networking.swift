//
//  Networking.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

enum NetworkingError: Error {
    case requestFailed
    case networkError
    case clientError(Error)
}

protocol Networking: Sendable {
    /// Send passed request to network
    /// - Parameter request: Request for sending.
    /// - Throws:`NetworkingError` type of error.
    /// - Returns: Body of response typeof `Data`.
    func send(_ request: URLRequest) async throws(NetworkingError) -> Data
}
