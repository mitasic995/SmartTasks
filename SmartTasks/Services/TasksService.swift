//
//  TasksService.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

private enum Constants {
    static let getTasksRequestUrl = "http://demo9877360.mockable.io/"
}

class TasksService {
    private let decoder: JSONDecoder
    private let httpClient: Networking
    
    init(httpClient: Networking) {
        self.httpClient = httpClient
        self.decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        self.decoder.dateDecodingStrategy = .formatted(formatter)
    }
}

extension TasksService: TasksProviding {
    func tasks() async throws -> [Task] {
        guard let url = URL(string: Constants.getTasksRequestUrl) else { throw URLError(.badURL) }
        
        let request = URLRequest(url: url)
        
        let data = try await httpClient.send(request)
        
        let dto = try decoder.decode(Tasks.self, from: data)
        
        return dto.tasks
    }
}
