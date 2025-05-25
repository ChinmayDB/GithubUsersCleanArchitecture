//
//  UserDetailsViewModel.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

final class UserDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var userDetail: GithubUserDetails?
    @Published private(set) var projectRepositories: [GithubProjectRepository] = []
    @Published private(set) var hasMoreProjectRepositories = true
    @Published private(set) var isLoading = false
    @Published private(set) var isNetworkConnectionLost: Bool = false
    @Published var error: String?
    
    private var page = 0
    private let userRepository: UserRepositoryProtocol
    private let login: String
    private let getOwnProjectRepositoriesUseCase: GetOwnProjectRepositoriesUseCaseExecutable
    private var networkMonitor: NetworkMonitorProtocol
    
    // MARK: - Constructor
    
    init(
        userRepository: UserRepositoryProtocol = Repository.shared.user,
        login: String,
        getOwnProjectRepositoriesUseCase: GetOwnProjectRepositoriesUseCaseExecutable,
        networkMonitor: NetworkMonitorProtocol = NetworkMonitor()
    ) {
        self.userRepository = userRepository
        self.login = login
        self.getOwnProjectRepositoriesUseCase = getOwnProjectRepositoriesUseCase
        self.networkMonitor = networkMonitor
        monitorNetwork()
    }

    // MARK: - Methods
     
    private func monitorNetwork() {
        networkMonitor.startMonitoring { [weak self] newState in
            guard let self else { return }
            self.isNetworkConnectionLost = newState
        }
    }
    
    @MainActor
    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            async let detail = userRepository.fetchUserDetails(login: login)
            await loadMoreProjectRepositories()
            userDetail = try await detail
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    func loadMoreProjectRepositories() async {
        guard hasMoreProjectRepositories else { return }
        
        let result = await getOwnProjectRepositoriesUseCase.execute(page: page)
        
        switch result {
        case .success(let repositories):
            self.projectRepositories.append(contentsOf: repositories)
            page += 1
        case .noData:
            hasMoreProjectRepositories = false
            break
        case .failure:
            // Failure
            break
        }
    }
}
