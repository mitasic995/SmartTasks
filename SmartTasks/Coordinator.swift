//
//  Coordinator.swift
//  SmartTasks
//
//  Created by Milos Tasic on 7. 10. 2025..
//

import SwiftUI

enum AppScreens: Hashable {
    case intro
    case tasks
    case taskDetails(SmartTask)
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    private let dependencyContainer: DependencyContainer
    
    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }
    
    func push(_ screen: AppScreens) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    @MainActor @ViewBuilder
    func build(screen: AppScreens) -> some View {
        switch screen {
        case .intro:
            IntroView()
        case .tasks:
            TasksView(repository: dependencyContainer.tasksRepository, taskScheduler: dependencyContainer.taskScheduler)
        case let .taskDetails(model):
            TaskDetailsView(model: model)
        }
    }
}
