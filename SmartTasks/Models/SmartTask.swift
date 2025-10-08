//
//  SmartTask.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import Foundation
import struct SwiftUICore.Color

struct SmartTask: Hashable {
    enum Status {
        case resolved
        case unresolved
        case cantResolve
    }
    let id: String
    let dueDate: String
    let title: String
    let description: String
    let priority: Int
    let comment: String?
    let status: Status
    let daysLeft: String
    
    var statusString: String {
        switch status {
        case .resolved:
            "Resolved"
        case .unresolved:
            "Unresolved"
        case .cantResolve:
            "Unresolved"
        }
    }
    
    var statusColor: Color {
        switch status {
        case .resolved:
            Color.smartTasksGreen
        case .unresolved:
            Color.smartTasksYellow
        case .cantResolve:
            Color.smartTasksRed
        }
    }
}
