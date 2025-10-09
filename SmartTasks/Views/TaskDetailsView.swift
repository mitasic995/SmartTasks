//
//  TaskDetailsView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var model: SmartTask
    
    @State private var taskStatus: SmartTask.Status
    
    init(model: SmartTask) {
        self._taskStatus = State(wrappedValue: model.status)
        self.model = model
    }
    
    var body: some View {
        ZStack {
            Color.smartTasksYellow
                .ignoresSafeArea()
            VStack {
                Image(ImageResource.taskDetailsBg)
                    .resizable()
                    .frame(height: 200)
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
                            
                            Text($taskStatus.wrappedValue.statusString)
                                .font(.smartTasksBold(15))
                                .foregroundStyle($taskStatus.wrappedValue.statusColor)
                                .padding(.top, Constants.Spaces.medium)
                        }
                        .padding(.horizontal, 2 * Constants.Spaces.medium)
                    }
                
                HStack(spacing: 16) {
                    Button(action: {
                        taskStatus = .resolved
                    }) {
                        Text("Resolve")
                            .font(.smartTasksBold(15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.smartTasksGreen)
                            .cornerRadius(Constants.cornerRadius)
                    }
                    
                    Button(action: {
                        taskStatus = .cantResolve
                    }) {
                        Text("Can't resolve")
                            .font(.smartTasksBold(15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.smartTasksRed)
                            .cornerRadius(Constants.cornerRadius)
                    }
                }
                .opacity(taskStatus == .unresolved ? 1 : 0)
                .padding(.horizontal, Constants.Spaces.medium)

                if taskStatus != .unresolved {
                    Image(taskStatus == .resolved ? ImageResource.resolvedSign : ImageResource.unresolvedSign)
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
