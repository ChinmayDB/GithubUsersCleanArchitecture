//
//  MockUserRepository.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 01/05/25.
//

import Foundation
@testable import GithubUsers

final class MockUserRepository: UserRepositoryProtocol {
    
    var usersResult: Result<[GithubUsers.GithubUser], Error>?
    var userDetailsResult: Result<GithubUsers.GithubUserDetails, Error>?
    
    init(
        usersResult: Result<[GithubUsers.GithubUser], Error>? = nil,
        userDetailsResult: Result<GithubUsers.GithubUserDetails, Error>? = nil
    ) {
        self.usersResult = usersResult
        self.userDetailsResult = userDetailsResult
    }
    
    func fetchUsers(since: Int) async throws -> [GithubUsers.GithubUser] {
        guard let usersResult else {
            throw NSError(domain: "Incorrect funtion call", code: -1)
        }
        switch usersResult {
            case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
    
    func fetchUserDetails(login: String) async throws -> GithubUsers.GithubUserDetails {
        guard let userDetailsResult else {
            throw NSError(domain: "Incorrect funtion call", code: -1)
        }
        switch userDetailsResult {
            case .success(let userDetails):
            return userDetails
        case .failure(let error):
            throw error
        }
    }
}
