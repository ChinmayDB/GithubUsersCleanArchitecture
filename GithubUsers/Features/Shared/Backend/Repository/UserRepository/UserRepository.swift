//
//  UsersRequest.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

protocol UserRepositoryProtocol {
    func fetchUsers(since: Int) async throws -> [GithubUser]
    func fetchUserDetails(login: String) async throws -> GithubUserDetails
}

final class UserRepository: UserRepositoryProtocol {
    
    private let sessionManager: SessionManaging

    init(sessionManager: SessionManaging = SessionManager.shared) {
        self.sessionManager = sessionManager
    }
    
    func fetchUsers(since: Int) async throws -> [GithubUser] {
        try await sessionManager.request(.users(since: since))
    }
    
    func fetchUserDetails(login: String) async throws -> GithubUserDetails {
        try await sessionManager.request(.userDetails(loginName: login))
    }
}
