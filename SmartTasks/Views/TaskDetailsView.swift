//
//  TaskDetailsView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskDetailsViewModel
    
    init(model: SmartTask, actions: TaskDetailsViewModel.Actions) {
        self.viewModel = TaskDetailsViewModel(task: model, actions: actions)
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
                            TaskTitleView(title: viewModel.task.title, isResolved: .constant(viewModel.isTaskResolved))
                            
                            Divider()
                            
                            TaskDueDateView(dueDate: viewModel.task.dueDate, daysLeft: viewModel.task.daysLeft, isResolved: .constant(viewModel.isTaskResolved))
                            
                            Divider()
                            
                            Text(viewModel.task.description)
                            .lineLimit(6)
                            .font(.smartTasksRegular(10))
                            .padding(.vertical, Constants.Spaces.medium)
                            
                            Divider()
                            
                            Text(viewModel.task.status.statusString)
                                .font(.smartTasksBold(15))
                                .foregroundStyle(viewModel.task.status.statusColor)
                                .padding(.top, Constants.Spaces.medium)
                        }
                        .padding(.horizontal, 2 * Constants.Spaces.medium)
                    }
                
                HStack(spacing: 16) {
                    Button(action: {
                        Task { @MainActor in
                            await viewModel.resolveTask()
                        }
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
                        Task { @MainActor in
                            await viewModel.cantResolveTask()
                        }
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
                .opacity(viewModel.isTaskUnresolved ? 1 : 0)
                .padding(.horizontal, Constants.Spaces.medium)

                if !viewModel.isTaskUnresolved {
                    Image(viewModel.isTaskResolved ? ImageResource.resolvedSign : ImageResource.unresolvedSign)
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
        .task {
            await viewModel.updateTaskStatus()
        }
    }
}
