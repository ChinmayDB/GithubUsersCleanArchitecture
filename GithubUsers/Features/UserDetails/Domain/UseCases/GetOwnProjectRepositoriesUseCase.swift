//
//  GetOwnProjectRepositoriesUseCase.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

protocol GetOwnProjectRepositoriesUseCaseExecutable {
    
    func execute(
        page: Int
    ) async -> GetOwnProjectRepositoriesUseCase.Result
}

struct GetOwnProjectRepositoriesUseCase: GetOwnProjectRepositoriesUseCaseExecutable {
    
    enum Result: Equatable {
        case success(repositories: [GithubProjectRepository])
        case noData
        case failure
    }
    
    private let projectRepository: ProjectRepositoryProtocol
    private let loginName: String
    
    init(projectRepository: ProjectRepositoryProtocol, loginName: String) {
        self.projectRepository = projectRepository
        self.loginName = loginName
    }
    
    func execute(page: Int) async -> Result {
        do {
            let projectRepositories = try await projectRepository.fetchRepositories(of: loginName, for: page)
            let ownProjectRepositories = projectRepositories.filter { !$0.isFork }
            guard !ownProjectRepositories.isEmpty else {
                return .noData
            }
            return .success(repositories: ownProjectRepositories)
        } catch {
            // Log Error
            return .failure
        }
    }
}
