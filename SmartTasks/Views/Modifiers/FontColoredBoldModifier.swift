//
//  FontColoredBoldModifier.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import SwiftUICore

struct FontColoredBoldModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(Font.smartTasksBold(15))
            .foregroundStyle(color)
    }
}
