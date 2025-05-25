//
//  Endpoint+UsersTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

import XCTest
@testable import GithubUsers

final class Endpoint_UsersTests: XCTestCase {
    
    // MARK: - Test Users
    
    func test_users_path_setsCorrectPath() {
        // Arrange
        let expectedResult = "/users"
        let endpoint = Endpoint.users(since: 0)
        
        // Act
        let result = endpoint.path
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_users_method_usesGETMethod() {
        // Arrange
        let expectedResult = Endpoint.HTTPMethod.get
        let endpoint = Endpoint.users(since: 50)
        
        // Act
        let result = endpoint.method
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_users_queryItems_shouldIncludeExactlyOneQueryItems() {
        // Arrange
        let expectedResult = 1
        let endpoint = Endpoint.users(since: 50)
        
        // Act
        let result = endpoint.queryItems.count
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_users_queryItems_shouldContainExpectedQueryNames() {
        // Arrange
        let sinceName = "since"
        let endpoint = Endpoint.users(since: 0)
        
        // Act
        let names = endpoint.queryItems.map { $0.name }
        
        // Assert
        XCTAssertTrue(names.contains(sinceName))
    }
    
    func test_users_queryItemsValue_includesPaginationQueryItems() {
        // Arrange
        let expectedSinceResult = "50"
        let endpoint = Endpoint.users(since: 50)
        
        // Act
        let sinceData = endpoint.queryItems.first(where: { $0.name == "since" })
        guard let sinceData else {
            return XCTFail("since QueryItems not found")
        }
        let sinceResult = sinceData.value
        
        // Assert
        XCTAssertEqual(sinceResult, expectedSinceResult, "Was '\(String(describing: sinceResult))' but was expecting '\(expectedSinceResult)'")
    }
    
    func test_users_url_URLIsWellFormed() {
        // Arrange
        let endpoint = Endpoint.users(since: 50)
        
        // Act
        let url = endpoint.url.absoluteString
        
        // Assert
        XCTAssertTrue(url.contains("https://api.github.com/users"))
        XCTAssertTrue(url.contains("since=50"))
    }
    
    // MARK: - test userDetails
    
    func test_userDetails_path_setsCorrectPath() {
        // Arrange
        let expectedResult = "/users/Chinmay"
        let endpoint = Endpoint.userDetails(loginName: "Chinmay")
        
        // Act
        let result = endpoint.path
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_userDetails_method_usesGETMethod() {
        
        // Arrange
        let expectedResult = Endpoint.HTTPMethod.get
        let endpoint = Endpoint.userDetails(loginName: "Chinmay")
        
        // Act
        let result = endpoint.method
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_userDetails_queryItems_shouldIncludeExactlyZeroQueryItems() {
        // Arrange
        let expectedResult = 0
        let endpoint = Endpoint.userDetails(loginName: "Chinmay")
        
        // Act
        let result = endpoint.queryItems.count
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_userDetails_url_URLIsWellFormed() {
        // Arrange
        let endpoint = Endpoint.userDetails(loginName: "Chinmay")
        
        // Act
        let url = endpoint.url.absoluteString
        
        // Assert
        XCTAssertTrue(url.contains("https://api.github.com/users/Chinmay"))
    }
}

