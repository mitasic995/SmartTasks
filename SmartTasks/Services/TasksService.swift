//
//  TasksService.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

private enum Constants {
    static let getTasksRequestUrl = "https://demo9877360.mockable.io/"
}

enum TasksServiceError: Error {
    case failedToDecodeResponse
}

final class TasksService {
    private let decoder: JSONDecoder
    private let httpClient: Networking
    
    init(httpClient: Networking) {
        self.httpClient = httpClient
        self.decoder = JSONDecoder()
    }
}

extension TasksService: TasksProviding {
    func tasks() async throws -> [TaskModel] {
        do {
            guard let url = URL(string: Constants.getTasksRequestUrl) else { throw URLError(.badURL) }
            
            let request = URLRequest(url: url)
            
            let data = try await httpClient.send(request)
            
            let dto = try decoder.decode(TasksModel.self, from: data)
            
            return dto.tasks
        } catch is DecodingError {
            throw TasksServiceError.failedToDecodeResponse
        } catch {
            throw error
        }
    }
}
