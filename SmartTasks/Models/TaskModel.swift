//
//  Task.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import Foundation

/// Inner DTO model of main endpoint response.
struct TaskModel {
    let id: String
    var targetDate: Date
    let dueDate: Date?
    let title: String
    let description: String
    let priority: Int
}

extension TaskModel: Decodable {

     static var dateFormatter: DateFormatter {
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy'-'MM'-'dd"
         formatter.timeZone = .gmt
         formatter.calendar = .init(identifier: .iso8601)
         return formatter
     }
    
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
        let targetDateString = try container.decode(String.self, forKey: .targetDate)
        self.targetDate = TaskModel.dateFormatter.date(from: targetDateString) ?? Date()
        let dueDateString = try container.decodeIfPresent(String.self, forKey: .dueDate) ?? ""
        self.dueDate = TaskModel.dateFormatter.date(from: dueDateString) ?? nil
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority) ?? 0
    }
}
