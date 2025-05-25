//
//  UsersViewModel.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

class UsersViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private(set) var users: [GithubUser] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var hasMoreData = true
    @Published private(set) var isNetworkConnectionLost: Bool = false
    @Published var error: Error?
    
    private var userRepository: UserRepositoryProtocol
    private var networkMonitor: NetworkMonitorProtocol
    private var since: Int = 0
    
    // MARK: - Constructor
    init(
        userRepository: UserRepositoryProtocol = Repository.shared.user,
        networkMonitor: NetworkMonitorProtocol = NetworkMonitor()
    ) {
        self.userRepository = userRepository
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
        guard !isLoading && hasMoreData else { return }
        
        isLoading = true
        
        do {
            let newUsers = try await userRepository.fetchUsers(since: since)
            users.append(contentsOf: newUsers)
            since = newUsers.last?.id ?? since
            hasMoreData = !newUsers.isEmpty
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    deinit {
        networkMonitor.stopMonitoring()
    }
}
