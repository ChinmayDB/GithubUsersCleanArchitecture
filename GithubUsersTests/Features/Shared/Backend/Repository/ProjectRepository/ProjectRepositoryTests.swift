//
//  ProjectRepositoryTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

import XCTest
@testable import GithubUsers

final class ProjectRepositoryTests: XCTestCase {
    
    func test_fetchRepositories_Success() async throws {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: true, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        
        let repository = ProjectRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        
        // Act
        let result = try await repository.fetchRepositories(of: "testuser", for: 1)
        
        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "AwesomeProject")
    }
    
    func test_fetchRepositories_Failure() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        
        let repository = ProjectRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        
        // Act / Assert
        do {
            _ = try await repository.fetchRepositories(of: "testuser", for: 1)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
        }
    }
}
