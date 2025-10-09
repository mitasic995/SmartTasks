//
//  SmartTasksApp.swift
//  SmartTasks
//
//  Created by Milos Tasic on 5. 10. 2025..
//

import SwiftUI

@main
struct SmartTasksApp: App {
    @State var introPresenting = true
    var body: some Scene {
        WindowGroup {
            ZStack {
                CoordinatorView()
                // Splash screen
                IntroView()
                    .opacity(introPresenting ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeOut) {
                                introPresenting = false
                            }
                        }
                    }
            }
            
        }
    }
}
