//
//  TasksView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: TasksViewModel
    
    init(service: TasksProviding) {
        _viewModel = StateObject(wrappedValue: TasksViewModel(tasksService: service))
    }
    
    var body: some View {
        ZStack {
            Color.smartTasksYellow
                .ignoresSafeArea()
            if !viewModel.smartTasks.isEmpty {
                VStack {
                    ScrollView {
                        ForEach(viewModel.smartTasks, id: \.id) { task in
                            TaskView(title: task.title, dueDate: task.dueDate, daysLeft: task.daysLeft)
                                .onTapGesture {
                                    coordinator.push(.taskDetails(task))
                                }
                        }
                        .frame(width: 298)
                    }
                    .scrollIndicators(.hidden)
                }
            } else {
                NoTasksForToday()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.smartTasksYellow, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.title)
                    .font(.smartTasksBold(20)) // TODO: Move to ViewModifier
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.goBackForOneDay()
                }) {
                    Image(ImageResource.arrowBack)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.goForwardForOneDay()
                }) {
                    Image(ImageResource.arrowForward)
                }
            }
        }
        .task {
            await viewModel.fetchTasks()
        }
    }
}


private struct NoTasksForToday: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("Empty screen illustration")
            Text("No tasks for today!")
                .font(.smartTasksBold(35))
                .foregroundStyle(.white)
        }
    }
}

//#Preview {
//    TasksView(viewModel: TasksViewModel(tasksService: TasksService(httpClient: URLSession.shared)))
//}
