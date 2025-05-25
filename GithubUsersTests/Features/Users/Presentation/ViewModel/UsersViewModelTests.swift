//
//  UsersViewModelTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

import XCTest
@testable import GithubUsers

final class UsersViewModelTests: XCTestCase {
    
    // MARK: - Test isNetworkConnectionLost
    
    func test_isNetworkConnectionLost_withSimulatedLostConnection_shouldReturnFalse() {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        mockNetworkMonitor.simulateLostConnection(lost: true)
        
        // Assert
        XCTAssertTrue(usersViewModel.isNetworkConnectionLost, "Was '\(usersViewModel.isNetworkConnectionLost)' but was expecting 'true'")
    }
    
    func test_isNetworkConnectionLost_withNoSimulatedLostConnection_shouldReturnFalse() {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        mockNetworkMonitor.simulateLostConnection(lost: false)
        
        // Assert
        XCTAssertFalse(usersViewModel.isNetworkConnectionLost, "Was '\(usersViewModel.isNetworkConnectionLost)' but was expecting 'false'")
    }
    
    // MARK: - Test isLoading
    
    func test_isLoading_withoutExecutingLoad_shouldReturnFalse() async {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act / Assert
        XCTAssertFalse(usersViewModel.isLoading, "Was '\(usersViewModel.isLoading)' but was expecting 'false'")
    }
    
    func test_isLoading_withMockedDataForFetchUsers_shouldReturnFalse() async {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        await usersViewModel.load()
        
        // Assert
        XCTAssertFalse(usersViewModel.isLoading, "Was '\(usersViewModel.isLoading)' but was expecting 'false'")
    }
    
    // MARK: - Test hasMoreData
    
    func test_hasMoreData_withMockedDataForFetchUsers_shouldReturnTrue() async {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        await usersViewModel.load()
        
        // Assert
        XCTAssertTrue(usersViewModel.hasMoreData, "Was '\(usersViewModel.hasMoreData)' but was expecting 'true'")
    }
    
    // MARK: - Test error
    
    func test_error_withoutExecutingLoad_shouldReturnNil() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act / Assert
        XCTAssertNil(usersViewModel.error, "Was '\(String(describing: usersViewModel.error))' but was expecting 'nil'")
    }
    
    func test_error_withMockedFailure_shouldReturnNil() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        await usersViewModel.load()
        
        // Assert
        XCTAssertNotNil(usersViewModel.error, "Was '\(String(describing: usersViewModel.error))' but was expecting 'Not nil'")
    }
    
    func test_error_withMockedDataForFetchUsers_shouldReturnNil() async {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        let expectedResult = [sampleRepoOne, sampleRepoTwo]
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        await usersViewModel.load()
        
        // Assert
        XCTAssertNil(usersViewModel.error, "Was '\(String(describing: usersViewModel.error))' but was expecting 'Nil'")
    }
    
    // MARK: - test users
    
    func test_users_withoutExecutingLoad_shouldReturnEmpty() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act / Assert
        XCTAssertTrue(usersViewModel.users.isEmpty, "Was '\(String(describing: usersViewModel.users.isEmpty))' but was expecting 'true'")
    }
    
    func test_users_withMockedFailureForFetchUsers_shouldReturnEmpty() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        await usersViewModel.load()
        
        // Assert
        XCTAssertTrue(usersViewModel.users.isEmpty, "Was '\(String(describing: usersViewModel.users.isEmpty))' but was expecting 'true'")
    }
    
    func test_users_withMockedDataForFetchUsers_shouldReturnExpectedUsers() async {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        let expectedResult = [sampleRepoOne, sampleRepoTwo]
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        let mockNetworkMonitor = MockNetworkMonitor()
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        let usersViewModel = UsersViewModel(userRepository: userRepository, networkMonitor: mockNetworkMonitor)
        
        // Act
        await usersViewModel.load()
        let result = usersViewModel.users
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting \(expectedResult)")
    }
}

