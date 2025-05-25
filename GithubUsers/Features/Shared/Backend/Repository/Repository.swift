//
//  Repository.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

protocol RepositoryProtocol {
    var user: UserRepositoryProtocol { get }
    var projectRepository: ProjectRepositoryProtocol { get }
}

final class Repository: RepositoryProtocol {
    
    static let shared = Repository()
    
    var user: UserRepositoryProtocol {
        UserRepository()
    }
    
    var projectRepository: ProjectRepositoryProtocol {
        ProjectRepository()
    }
    
    private init() {
        // do nothing
    }
}
