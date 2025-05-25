//
//  MockProjectRepository.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 01/05/25.
//

import Foundation
@testable import GithubUsers

final class MockProjectRepository: ProjectRepositoryProtocol {
    
    var repositoriesResult: Result<[GithubUsers.GithubProjectRepository], Error>?
    
    init(
        repositoriesResult: Result<[GithubUsers.GithubProjectRepository], Error>? = nil
    ) {
        self.repositoriesResult = repositoriesResult
    }
    
    func fetchRepositories(of loginName: String, for page: Int) async throws -> [GithubUsers.GithubProjectRepository] {
        guard let repositoriesResult else {
            throw NSError(domain: "Incorrect funtion call", code: -1)
        }
        switch repositoriesResult {
            case .success(let repositories):
            return repositories
        case .failure(let error):
            throw error
        }
    }
}
