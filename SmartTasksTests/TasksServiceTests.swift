//
//  TasksServiceTests.swift
//  SmartTasksTests
//
//  Created by Milos Tasic on 6. 10. 2025..
//

import Testing
import Foundation
@testable import SmartTasks

final class TasksServiceTests {
    private let networkingMock = NetworkingMock()
    private var sut: TasksService!
    
    init() {
        sut = TasksService(httpClient: networkingMock)
    }
    
    deinit {
        sut = nil
    }
    
    @Test("Decoding fetched array of `Tasks`.")
    func tasks() async {
        // Given
        networkingMock.stubData = responseMock
        
        // When
        do {
            let tasks = try await sut.getTasks()
            // Then
            #expect(!tasks.isEmpty)
            #expect(tasks.count == 18)
        } catch {
            Issue.record("Should now throw an error.")
        }
    }
    
    @Test("Catching error while decoding into a model.")
    func tasks_WhenInvalidJsonResponse_ShouldThrowAnError() async {
        // Given
        networkingMock.stubData = "wrong json".data(using: .utf8)
        
        // Then
        await #expect(throws: TasksServiceError.failedToDecodeResponse) {
            // When
            try await sut.getTasks()
        }
    }
}
