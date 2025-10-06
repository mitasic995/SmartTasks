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

protocol Networking {
    func send(_ request: URLRequest) async throws(NetworkingError) -> Data
}
