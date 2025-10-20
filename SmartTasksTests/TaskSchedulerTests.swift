//
//  TaskSchedulerTests.swift
//  SmartTasksTests
//
//  Created by Milos Tasic on 8. 10. 2025..
//

import Testing
import Foundation
@testable import SmartTasks

struct TaskSchedulerTests {

    @Test func scheduleTasks() async throws {
        // Given
        let calendar = Calendar(identifier: .iso8601)
        let component = DateComponents(
            calendar: calendar,
            timeZone: .gmt,
            year: 2025,
            month: 11,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
            nanosecond: 0
        )
        let mockToday = calendar.date(from: component) ?? Date.distantPast
        let decoder = JSONDecoder()
        let tasks = try decoder.decode(TasksModel.self, from: responseMock ?? Data()).tasks
        
        // When
        let schedule = TaskScheduler.scheduleTasks(tasks, forToday: mockToday)
        
        // Then
        #expect(schedule[mockToday]?.count == 3)
    }
}
