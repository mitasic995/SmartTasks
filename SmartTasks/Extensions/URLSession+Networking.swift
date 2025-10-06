//
//  URLSession+Networking.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

extension URLSession: Networking {
    func send(_ request: URLRequest) async throws(NetworkingError) -> Data {
        do {
            let (data, response) = try await data(for: request)
            guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkingError.networkError }
            guard (200...299).contains(httpUrlResponse.statusCode) else { throw NetworkingError.requestFailed }
            
            return data
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw NetworkingError.clientError(error)
        }
    }
}
