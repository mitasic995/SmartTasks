//
//  TaskDetailsView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let model: SmartTask
    
    var body: some View {
        ZStack {
            Color.smartTasksYellow
                .ignoresSafeArea()
            VStack {
                Image(ImageResource.taskDetailsBg)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, Constants.Spaces.medium)
                    .overlay {
                        VStack(alignment: .leading, spacing: 0) {
                            TaskTitleView(title: model.title)
                            
                            Divider()
                            
                            TaskDueDateView(dueDate: model.dueDate, daysLeft: model.daysLeft)
                            
                            Divider()
                            
                            Text(model.description)
                            .lineLimit(6)
                            .font(.smartTasksRegular(10))
                            .padding(.vertical, Constants.Spaces.medium)
                            
                            Divider()
                            
                            Text(model.statusString)
                                .font(.smartTasksBold(15))
                                .foregroundStyle(model.statusColor)
                                .padding(.top, Constants.Spaces.medium)
                            
                        }
                        .padding(.horizontal, 2 * Constants.Spaces.medium)
                    }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.smartTasksYellow, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
               Text("Task Detail")
                    .font(.smartTasksBold(20))
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(ImageResource.arrowBack)
                }
            }
        }
    }
}
