//
//  SmartTask.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import Foundation
import struct SwiftUICore.Color

/// UI model that holds everything neccesery to be presented.
struct SmartTask: Hashable {
    enum Status {
        case resolved
        case unresolved
        case cantResolve
        
        var statusString: String {
            switch self {
            case .resolved:
                "Resolved"
            case .unresolved:
                "Unresolved"
            case .cantResolve:
                "Unresolved"
            }
        }
        
        var statusColor: Color {
            switch self {
            case .resolved:
                Color.smartTasksGreen
            case .unresolved:
                Color.orange
            case .cantResolve:
                Color.smartTasksRed
            }
        }
    }
    
    let id: String
    let dueDate: String
    let title: String
    let description: String
    let priority: Int
    var comment: String?
    var status: Status
    let daysLeft: String
}

