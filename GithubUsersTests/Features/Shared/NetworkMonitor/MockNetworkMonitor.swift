//
//  MockNetworkMonitor.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 30/04/25.
//

@testable import GithubUsers

class MockNetworkMonitor: NetworkMonitorProtocol {
    
    private var onChange: ((Bool) -> Void)?
    
    func startMonitoring(onChange: @escaping (Bool) -> Void) {
        self.onChange = onChange
    }
    
    func stopMonitoring() {
        // not used
    }
    
    func simulateLostConnection(lost: Bool) {
        onChange?(lost)
    }
}
