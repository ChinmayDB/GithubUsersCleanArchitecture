//
//  GetOwnProjectRepositoriesUseCaseTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 01/05/25.
//

import XCTest
@testable import GithubUsers

final class GetOwnProjectRepositoriesUseCaseTests: XCTestCase {
    
    // MARK: - Test isNetworkConnectionLost
    
    func test_execute_withMockedTwoData_shouldReturnResultAsSuccess() async {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: true, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let expectedResult =  GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne]) // as we ignore Forked repositories
        let projectRepository = ProjectRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let getOwnProjectRepositoriesUseCase = GetOwnProjectRepositoriesUseCase(projectRepository: projectRepository, loginName: "Chinmay")
        // Act
        let result = await getOwnProjectRepositoriesUseCase.execute(page: 1)
        
        // Assert
        XCTAssertEqual(expectedResult,result, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_execute_withMocked_shouldReturnResultAsNoData() async {
        // Arrange
        let mockService = MockNetworkService()
        mockService.result = .success([])
        let expectedResult =  GetOwnProjectRepositoriesUseCase.Result.noData
        let projectRepository = ProjectRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let getOwnProjectRepositoriesUseCase = GetOwnProjectRepositoriesUseCase(projectRepository: projectRepository, loginName: "Chinmay")
        // Act
        let result = await getOwnProjectRepositoriesUseCase.execute(page: 1)
        
        // Assert
        
        XCTAssertEqual(expectedResult,result, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_execute_withMockedFailure_shouldReturnResultAsFailue() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        let expectedResult =  GetOwnProjectRepositoriesUseCase.Result.failure
        let projectRepository = ProjectRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let getOwnProjectRepositoriesUseCase = GetOwnProjectRepositoriesUseCase(projectRepository: projectRepository, loginName: "Chinmay")
        // Act
        let result = await getOwnProjectRepositoriesUseCase.execute(page: 1)
        
        // Assert
        XCTAssertEqual(expectedResult,result, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
}
