//
//  Font+Extensions.swift
//  SmartTasks
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import SwiftUICore

/// Helpers for using app's custom fonts.
extension Font {
    static func smartTasksRegular(_ size: CGFloat) -> Self {
        return .custom("AmsiPro-Regular", size: size)
    }
    
    static func smartTasksBold(_ size: CGFloat) -> Self {
        return .custom("AmsiPro-Bold", size: size)
    }
}

