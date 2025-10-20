//
//  TaskRepositoryTests.swift
//  SmartTasksTests
//
//  Created by Milos Tasic on 10. 10. 2025..
//

import Foundation
import Testing
@testable import SmartTasks

final class TaskRepositoryTests {
    private let localSource = LocalSourceMock()
    private let remoteSource = RemoteSourceMock()
    private var sut: TasksRepository!
    
    init() {
        sut = SmartTasksRepository(localSource: localSource, remoteSource: remoteSource)
    }
    
    deinit {
        sut = nil
    }
    
    @Test func fetchTasks_WhenNotLocallyStored_ShouldCallRemoteSource() async {
        do {
            // When
            let tasks = try await sut.fetchTasks()
            // Then
            #expect(tasks.count == 1)
            #expect(await localSource.readFromCalled)
            #expect(await remoteSource.getTasksCalled)
        } catch {
            Issue.record("Should not fail.")
        }
    }
    
    @Test func fetchTasks_WhenFetchedFromRemote_ShouldSaveLocally() async {
        do {
            // When
            let _ = try await sut.fetchTasks()
            
            // Then
            #expect(await localSource.writeToCalled)
        } catch {
            Issue.record("Should not fail.")
        }
    }
    
    @Test func fetchTasks_WhenLocallyStored_ShouldNotCallRemoteSource() async {
        // Given
        let encoder = JSONEncoder()
        let mockModel = [
            TaskModel(id: "1", targetDate: .now, dueDate: nil, title: "title", description: "desc", priority: 1)
        ]
        do {
            let mockData = try encoder.encode(mockModel)
            await localSource.stubData(mockData)
            
            // When
            let _ = try await sut.fetchTasks()
            
            // Then
            #expect(await localSource.readFromCalled)
            #expect(await remoteSource.getTasksCalled == false)
        } catch {
            Issue.record("Should not fail.")
        }
    }
    
    @Test func resolveTask() async {
        // Given
        let id = "1"
        // When
        let successfuly = await sut.resolveTask(id: id)
        
        // Then
        #expect(successfuly)
        #expect(await localSource.writeToCalled)
    }
    
    @Test func cantResolveTask() async {
        // Given
        let id = "1"
        
        // When
        let successfuly = await sut.cantResolveTask(id: id)
        
        // Then
        #expect(successfuly)
        #expect(await localSource.writeToCalled)
    }
    
    @Test func tasksStatus_WhenNoRecordOfTasks_ShouldReturnStatusUnresolved() async {
        // Given
        let id = "1"
        
        // When
        let status = await sut.tasksStatus(id: id)
        
        // Then
        #expect(status == .unresolved)
        #expect(await localSource.readFromCalled)
    }
    
    @Test func tasksStatus_WhenTheresRecordInRepo_ShouldReturnCorrectStatus() async {
        // Given
        let id = "1"
        let expectedStatus = SmartTask.Status.resolved
        let encoder = JSONEncoder()
        let data = try? encoder.encode(expectedStatus)
        await localSource.stubData(data ?? Data())

        // When
        let status = await sut.tasksStatus(id: id)

        // Then
        #expect(await localSource.readFromCalled)
        #expect(status == expectedStatus)
    }
}
