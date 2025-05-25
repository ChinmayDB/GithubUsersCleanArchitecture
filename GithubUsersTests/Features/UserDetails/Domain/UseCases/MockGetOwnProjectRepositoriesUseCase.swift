//
//  MockGetOwnProjectRepositoriesUseCase.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 01/05/25.
//

import Foundation
@testable import GithubUsers

final class MockGetOwnProjectRepositoriesUseCase: GetOwnProjectRepositoriesUseCaseExecutable {
    
    let ownProjectRepositoriesResult: GithubUsers.GetOwnProjectRepositoriesUseCase.Result
    
    init(
        ownProjectRepositoriesResult: GithubUsers.GetOwnProjectRepositoriesUseCase.Result,
    ) {
        self.ownProjectRepositoriesResult = ownProjectRepositoriesResult
    }
    
    func execute(page: Int) async -> GithubUsers.GetOwnProjectRepositoriesUseCase.Result {
        return ownProjectRepositoriesResult
    }
}
