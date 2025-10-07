//
//  CoordinatorView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 7. 10. 2025..
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var coordinator = Coordinator(dependencyContainer: DependencyContainer())
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(screen: .tasks)
                .navigationDestination(for: AppScreens.self) { screen in
                    coordinator.build(screen: screen)
                }
                
        }
        .environmentObject(coordinator)
    }
}
