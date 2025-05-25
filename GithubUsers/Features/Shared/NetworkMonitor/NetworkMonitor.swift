//
//  NetworkMonitor.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Network

protocol NetworkMonitorProtocol {
    mutating func startMonitoring(onChange: @escaping (Bool) -> Void)
    func stopMonitoring()
}

struct NetworkMonitor {
    private var monitor: NWPathMonitor?
}

extension NetworkMonitor: NetworkMonitorProtocol {
    
    public mutating func startMonitoring(onChange: @escaping (Bool) -> Void) {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { path in
            onChange(path.status != .satisfied)
        }
        monitor?.start(queue: .main)
    }
    
    public func stopMonitoring() {
        monitor?.cancel()
    }
}
