//
//  Endpoint+RepositoriesTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

import XCTest
@testable import GithubUsers

final class Endpoint_RepositoriesTests: XCTestCase {
    
    func test_repositories_path_setsCorrectPath() {
        // Arrange
        let expectedResult = "/users/octocat/repos"
        let endpoint = Endpoint.repositories(of: "octocat", for: 2)
        
        // Act
        let result = endpoint.path
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_repositories_method_usesGETMethod() {
        // Arrange
        let expectedResult = Endpoint.HTTPMethod.get
        let endpoint = Endpoint.repositories(of: "any", for: 1)
        
        // Act
        let result = endpoint.method
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_repositories_queryItems_shouldIncludeExactlyTwoQueryItems() {
        // Arrange
        let expectedResult = 2
        let endpoint = Endpoint.repositories(of: "testuser", for: 3)
        
        // Act
        let result = endpoint.queryItems.count
        
        // Assert
        XCTAssertEqual(result, expectedResult, "Was '\(result)' but was expecting '\(expectedResult)'")
    }
    
    func test_repositories_queryItems_shouldContainExpectedQueryNames() {
        // Arrange
        let perPageName = "per_page"
        let pageName = "page"
        let endpoint = Endpoint.repositories(of: "user", for: 1)
        
        // Act
        let names = endpoint.queryItems.map { $0.name }
        
        // Assert
        XCTAssertTrue(names.contains(perPageName))
        XCTAssertTrue(names.contains(pageName))
    }
    
    func test_repositories_queryItemsValue_includesPaginationQueryItems() {
        // Arrange
        let expectedPerPageResult = "30"
        let expectedPageResult = "5"
        let endpoint = Endpoint.repositories(of: "dev", for: 5)
        
        // Act
        let perPageData = endpoint.queryItems.first(where: { $0.name == "per_page" })
        let pageData = endpoint.queryItems.first(where: { $0.name == "page" })
        guard let perPageData, let pageData else {
            return XCTFail("per_page & page QueryItems not found")
        }
        let perPageResult = perPageData.value
        let pageResult = pageData.value
        
        // Assert
        XCTAssertEqual(perPageResult, expectedPerPageResult, "Was '\(String(describing: perPageResult))' but was expecting '\(expectedPerPageResult)'")
        XCTAssertEqual(pageResult, expectedPageResult, "Was '\(String(describing: pageResult))' but was expecting '\(expectedPageResult)'")
    }
    
    func test_repositories_url_URLIsWellFormed() {
        // Arrange
        let endpoint = Endpoint.repositories(of: "octocat", for: 1)
        
        // Act
        let url = endpoint.url.absoluteString
        
        // Assert
        XCTAssertTrue(url.contains("https://api.github.com/users/octocat/repos"))
        XCTAssertTrue(url.contains("per_page=30"))
        XCTAssertTrue(url.contains("page=1"))
    }
}
