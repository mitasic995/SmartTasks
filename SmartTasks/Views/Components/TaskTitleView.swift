//
//  TaskTitleView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import SwiftUI

struct TaskTitleView: View {
    let title: String
    @Binding var isResolved: Bool
    
    var body: some View {
        Text(title)
            .padding(.top, Constants.Spaces.medium)
            .padding(.bottom, Constants.Spaces.small)
            .font(Font.smartTasksBold(15))
            .foregroundStyle(isResolved ? Color.smartTasksGreen : Color.smartTasksRed)
    }
}
