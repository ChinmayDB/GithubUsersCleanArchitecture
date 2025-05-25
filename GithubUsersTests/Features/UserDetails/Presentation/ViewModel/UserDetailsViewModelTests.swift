//
//  UserDetailsViewModelTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 01/05/25.
//

import XCTest
@testable import GithubUsers

final class UserDetailsViewModelTests: XCTestCase {
    
    // MARK: - Test isNetworkConnectionLost
    
    func test_isNetworkConnectionLost_withSimulatedLostConnection_shouldReturnFalse() {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act
        mockNetworkMonitor.simulateLostConnection(lost: true)
        
        // Assert
        XCTAssertTrue(userDetailViewModel.isNetworkConnectionLost, "Was '\(userDetailViewModel.isNetworkConnectionLost)' but was expecting 'true'")
    }
    
    func test_isNetworkConnectionLost_withNoSimulatedLostConnection_shouldReturnFalse() {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act
        mockNetworkMonitor.simulateLostConnection(lost: false)
        
        // Assert
        XCTAssertFalse(userDetailViewModel.isNetworkConnectionLost, "Was '\(userDetailViewModel.isNetworkConnectionLost)' but was expecting 'false'")
    }
    
    // MARK: - Test isLoading
    
    func test_isLoading_withoutExecutingLoad_shouldReturnFalse() async {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Assert
        XCTAssertFalse(userDetailViewModel.isLoading, "Was '\(userDetailViewModel.isLoading)' but was expecting 'false'")
    }
    
    func test_isLoading_withMockedDataForLoad_shouldReturnFalse() async {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act
        await userDetailViewModel.load()
        
        // Assert
        XCTAssertFalse(userDetailViewModel.isLoading, "Was '\(userDetailViewModel.isLoading)' but was expecting 'false'")
    }
    
    // MARK: - Test hasMoreProjectRepositories
    
    func test_hasMoreProjectRepositories_withMockedData_shouldReturnTrue() async {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act
        await userDetailViewModel.load()
        
        // Assert
        XCTAssertTrue(userDetailViewModel.hasMoreProjectRepositories, "Was '\(userDetailViewModel.hasMoreProjectRepositories)' but was expecting 'true'")
    }
    
    func test_hasMoreProjectRepositories_withNoMockedProjectRepositoriesData_shouldReturnFalse() async {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.noData
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act
        await userDetailViewModel.load()
        
        // Assert
        XCTAssertFalse(userDetailViewModel.hasMoreProjectRepositories, "Was '\(userDetailViewModel.hasMoreProjectRepositories)' but was expecting 'false'")
    }
    
    // MARK: - Test error
    
    func test_error_withoutExecutingLoad_shouldReturnNil() async {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act / Assert
        XCTAssertNil(userDetailViewModel.error, "Was '\(String(describing: userDetailViewModel.error))' but was expecting 'nil'")
    }
    
    func test_error_withMockedDataForLoad_shouldReturnNil() async {
        // Arrange
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .success(sample))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act
        await userDetailViewModel.load()
        
        // Assert
        XCTAssertNil(userDetailViewModel.error, "Was '\(String(describing: userDetailViewModel.error))' but was expecting 'nil'")
    }
    
    func test_error_withMockedFailureDataForLoad_shouldReturnError() async {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: -1)
        let mockNetworkMonitor = MockNetworkMonitor()
        let mockUserRepository = MockUserRepository(userDetailsResult: .failure(expectedError))
        let sampleRepoOne = GithubProjectRepository(id: 1, name: "AwesomeProject", language: "Ruby", stargazersCount: 1234, description: "My first repo", isFork: false, htmlUrl: "https://github.com/test/repo", hasPages: false)
        let sampleRepoTwo = GithubProjectRepository(id: 1, name: "AwesomeProjectTwo", language: "Ruby", stargazersCount: 1234, description: "My first opensource repo", isFork: false, htmlUrl: "https://github.com/test/tworepo", hasPages: false)
        let ownProjectRepositoriesResult = GetOwnProjectRepositoriesUseCase.Result.success(repositories: [sampleRepoOne, sampleRepoTwo])
        let mockGetOwnProjectRepositoriesUseCase = MockGetOwnProjectRepositoriesUseCase(ownProjectRepositoriesResult: ownProjectRepositoriesResult)
        let userDetailViewModel = UserDetailViewModel(userRepository: mockUserRepository, login: "Chinmay", getOwnProjectRepositoriesUseCase : mockGetOwnProjectRepositoriesUseCase, networkMonitor: mockNetworkMonitor)
        
        // Act
        await userDetailViewModel.load()
        
        // Assert
        XCTAssertNotNil(userDetailViewModel.error, "Was '\(String(describing: userDetailViewModel.error))' but was expecting 'not nil'")
    }
}

