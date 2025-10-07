//
//  TaskView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import SwiftUI
private enum Constants {
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
    let dueDate: String
    let daysLeft: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Task title")
                .padding(.top, Constants.Spaces.medium)
                .padding(.bottom, Constants.Spaces.small)
                .font(Font.smartTasksBold(15))
                .foregroundStyle(.red)
            Divider()
            
            HStack {
                InnerView(label: "Due date", text: dueDate, alignment: .leading)
                Spacer()
                InnerView(label: "Days left", text: daysLeft, alignment: .trailing)
            }
            .padding([.top, .bottom], Constants.Spaces.medium)
        }
        .padding(.horizontal, Constants.Spaces.medium) // No guideline for this -> I eyeballed it.
        .background(.white)
        .frame(width: Constants.Sizes.width)
        .frame(minHeight: Constants.Sizes.minHeight)
        .cornerRadius(Constants.cornerRadius)
    }
}

private struct InnerView: View  {
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

#Preview {
    ZStack {
        Color.smartTasksYellow
        TaskView(dueDate: "10 Apr 2026", daysLeft: "10")
    }
}
