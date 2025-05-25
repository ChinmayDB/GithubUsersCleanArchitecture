//
//  UserRepositoryTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

import XCTest
@testable import GithubUsers

final class UserRepositoryTests: XCTestCase {
    
    // MARK: - test fetchUsers
    func test_fetchUsers_Success() async throws {
        // Arrange
        let mockService = MockNetworkService()
        let sampleRepoOne = GithubUser(id: 1, login: "Chinmay", avatar_url: "https://github.com/test/tworepo")
        let sampleRepoTwo = GithubUser(id: 2, login: "Vrushank", avatar_url: "https://github.com/test/tworepo")
        mockService.result = .success([sampleRepoOne, sampleRepoTwo])
        
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        
        // Act
        let result = try await userRepository.fetchUsers(since: 0)
        
        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.login, "Chinmay")
    }
    
    func test_fetchUsers_Failure() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        
        // Act / Assert
        do {
            _ = try await userRepository.fetchUsers(since: 0)
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
        }
    }
    
    // MARK: - test userDetails
    func test_fetchUsersDetails_Success() async throws {
        // Arrange
        let mockService = MockNetworkService()
        let sample = GithubUserDetails(
            login: "Chinmay",
            name: "Chinmay Balutkar",
            avatarUrl: URL(string: "https://github.com/test/tworepo")!,
            followers: 23,
            following: 679
        )
        
        mockService.result = .success(sample)
        
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        
        // Act
        let result = try await userRepository.fetchUserDetails(login: "Chinmay")
        
        // Assert
        XCTAssertEqual(result.login, "Chinmay")
    }
    
    func test_fetchUserDetails_Failure() async {
        // Arrange
        let mockService = MockNetworkService()
        let expectedError = NSError(domain: "TestError", code: -1)
        mockService.result = .failure(expectedError)
        
        let userRepository = UserRepository(sessionManager: SessionManager(networkService: mockService, token: "Unknown"))
        
        // Act / Assert
        do {
            _ = try await userRepository.fetchUserDetails(login: "Chinmay")
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
        }
    }
}
