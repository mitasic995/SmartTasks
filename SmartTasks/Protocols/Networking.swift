//
//  Networking.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

protocol Networking {
    func send(_ request: URLRequest) async throws -> (Data, URLResponse)
}
