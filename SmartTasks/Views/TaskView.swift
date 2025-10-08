//
//  TaskView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import SwiftUI
enum Constants {
    enum Spaces {
        static let small: CGFloat = 7
        static let medium: CGFloat = 10
    }
    
    enum Sizes {
        static let width: CGFloat = 298
        static let minHeight: CGFloat = 80
    }
    
    static let cornerRadius: CGFloat = 5
}

struct TaskView: View {
    let title: String
    let dueDate: String
    let daysLeft: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TaskTitleView(title: title)
            
            Divider()
            
            TaskDueDateView(dueDate: dueDate, daysLeft: daysLeft)
        }
        .padding(.horizontal, Constants.Spaces.medium) // No guideline for this -> I eyeballed it.
        .background(.white)
        .frame(width: Constants.Sizes.width)
        .frame(minHeight: Constants.Sizes.minHeight)
        .cornerRadius(Constants.cornerRadius)
    }
}

#Preview {
    ZStack {
        Color.smartTasksYellow
        TaskView(title: "Task title", dueDate: "10 Apr 2026", daysLeft: "10")
    }
}
