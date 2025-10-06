//
//  NetworkingMock.swift
//  SmartTasksTests
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import Foundation
@testable import SmartTasks

final class NetworkingMock: Networking {
    var stubData: Data?
    func send(_ request: URLRequest) async throws(SmartTasks.NetworkingError) -> Data {
        guard let stubData else { throw NetworkingError.requestFailed }
        
        return stubData
    }
}
