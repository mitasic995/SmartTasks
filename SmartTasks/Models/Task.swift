//
//  Task.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation
/*
    "id": "49dc9474cc5d4d0c9548c3953447f938",
    "TargetDate": "2025-09-15",
    "DueDate": "2025-09-20", // Can be null
    "Title": "Onboarding - Dev",
    "Description": "Prepare onboarding sessions for new Dev member to come. Previous onboarding sessions could be find at www.example.com",
    "Priority": 3 // Can be missing
*/
struct Task {
    let id: String
    let targetDate: Date
    let dueDate: Date?
    let title: String
    let description: String
    let priority: Int
}

extension Task: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case targetDate = "TargetDate"
        case dueDate = "DueDate"
        case title = "Title"
        case description = "Description"
        case priority = "Priority"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.targetDate = try container.decode(Date.self, forKey: .targetDate)
        self.dueDate = try container.decodeIfPresent(Date.self, forKey: .dueDate)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority) ?? 0
    }
}
