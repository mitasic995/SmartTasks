//
//  IntroView.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            Color.smartTasksYellow
            Image("Smart Tasks logo", bundle: .main)
            VStack {
                    Spacer()
                    Image("Intro screen illustration", bundle: .main)
            }
        }
        .onTapGesture {
            coordinator.push(.tasks)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    IntroView()
}
