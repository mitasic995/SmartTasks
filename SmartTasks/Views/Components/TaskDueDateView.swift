//
//  TaskDueDateView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import SwiftUI

struct TaskDueDateView: View {
    let dueDate: String
    let daysLeft: String
    
    var body: some View {
        HStack {
            TaskDateLabel(label: "Due date", text: dueDate, alignment: .leading)
            Spacer()
            TaskDateLabel(label: "Days left", text: daysLeft, alignment: .trailing)
        }
        .padding([.top, .bottom], Constants.Spaces.medium)
    }
}

private struct TaskDateLabel: View  {
    let label: String
    let text: String
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment, spacing: Constants.Spaces.small) {
            Text(label)
                .font(Font.smartTasksRegular(10))
                // Missing guideline for color
            Text(text)
                .boldedRed()
        }
    }
}
