//
//  ProjectRepository.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

protocol ProjectRepositoryProtocol {
    func fetchRepositories(of loginName: String, for page: Int) async throws -> [GithubProjectRepository]
}

final class ProjectRepository: ProjectRepositoryProtocol {
    private let sessionManager: SessionManaging

    init(sessionManager: SessionManaging = SessionManager.shared) {
        self.sessionManager = sessionManager
    }

    func fetchRepositories(of loginName: String, for page: Int) async throws -> [GithubProjectRepository] {
        try await sessionManager.request(.repositories(of: loginName, for: page))
    }
}

