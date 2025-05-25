//
//  SessionManager.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

protocol SessionManaging {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

class SessionManager: SessionManaging {
    
    static let shared = SessionManager(networkService: NetworkService())
    
    private var token: String = "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"
    private let networkService: NetworkServiceProtocol
    
    private init(networkService: NetworkServiceProtocol) { // Marks as Singleton pattern
        self.networkService = networkService
    }
    
#if DEBUG // only for mock testing
    init(networkService: NetworkServiceProtocol, token: String = "ghp_TEST_TOKEN") {
        self.networkService = networkService
        self.token = token
    }
#endif
    
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var authorizedEndpoint = endpoint
        
        // Inject Authorization Header
        var headers = authorizedEndpoint.headers
        headers["Authorization"] = "Bearer \(token)"
        authorizedEndpoint = Endpoint(
            path: authorizedEndpoint.path,
            method: authorizedEndpoint.method,
            queryItems: authorizedEndpoint.queryItems,
            headers: headers,
            body: authorizedEndpoint.body
        )
        
        do {
            return try await networkService.request(authorizedEndpoint)
        } catch {
            // You can add extra global error handling here (like refreshing token)
            throw error
        }
    }
}
