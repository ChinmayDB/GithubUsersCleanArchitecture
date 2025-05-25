//
//  MockNetworkService.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

import Foundation
@testable import GithubUsers

final class MockNetworkService: NetworkServiceProtocol {
    var requestedEndpoint: Endpoint?
    var result: Result<Any, Error> = .success([:])

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        self.requestedEndpoint = endpoint
        
        switch result {
        case .success(let data):
            guard let casted = data as? T else {
                throw NSError(domain: "TypeMismatch", code: 0)
            }
            return casted
        case .failure(let error):
            throw error
        }
    }
}
