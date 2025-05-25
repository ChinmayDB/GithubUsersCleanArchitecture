//
//  SessionManagerTests.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

import XCTest
@testable import GithubUsers

final class SessionManagerTests: XCTestCase {

    struct MockResponse: Codable, Equatable {
        let id: Int
        let name: String
    }

    func test_request_SuccessfulResponse_ReturnsDecodedObject() async throws {
        // Arrange
        let expectedResponse = MockResponse(id: 1, name: "Test")
        let mockService = MockNetworkService()
        mockService.result = .success(expectedResponse)

        let sessionManager = SessionManager(networkService: mockService)

        let endpoint = Endpoint(
            path: "/mock",
            method: .get,
            queryItems: [],
            headers: [:],
            body: nil
        )

        // Act
        let response: MockResponse = try await sessionManager.request(endpoint)

        // Assert
        XCTAssertEqual(response, expectedResponse)
        XCTAssertEqual(mockService.requestedEndpoint?.headers["Authorization"],
                       "Bearer ghp_TEST_TOKEN")
    }

    func test_request_ErrorThrown_PropagatesError() async {
        // Arrange
        let expectedError = URLError(.notConnectedToInternet)
        let mockService = MockNetworkService()
        mockService.result = .failure(expectedError)

        let sessionManager = SessionManager(networkService: mockService)

        let endpoint = Endpoint(
            path: "/mock",
            method: .get,
            queryItems: [],
            headers: [:],
            body: nil
        )

        // Act / Assert
        do {
            let _: MockResponse = try await sessionManager.request(endpoint)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }

    func test_request_AuthorizationHeaderInjected() async throws {
        // Arrange
        let expected = MockResponse(id: 1, name: "Authorized")
        let mockService = MockNetworkService()
        mockService.result = .success(expected)

        let sessionManager = SessionManager(networkService: mockService)

        let endpoint = Endpoint(path: "/secure", method: .get)

        // Act
        let _: MockResponse = try await sessionManager.request(endpoint)
        guard let headers = mockService.requestedEndpoint?.headers else {
            return XCTFail("No headers were passed to the request")
        }
        
        // Assert
        XCTAssertEqual(headers["Authorization"], "Bearer ghp_TEST_TOKEN")
    }
}
