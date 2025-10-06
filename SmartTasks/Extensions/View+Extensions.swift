//
//  View+Extensions.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import SwiftUICore

extension View {
    func boldedRed() -> some View {
        modifier(FontColoredBoldModifier(color: .smartTasksRed))
    }
    
    func boldedGreen() -> some View {
        modifier(FontColoredBoldModifier(color: .smartTasksGreen))
    }
}
