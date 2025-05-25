//
//  Endpoint+Repositories.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

extension Endpoint {
    ///
    /// Repositories
    ///
    /// - QueryItem:
    ///     - per_page: set to 30 items per page
    ///     - page: used for pagination
    ///
    /// - Important: HTTP Method Get
    ///
    static func repositories(of loginName: String, for page: Int) -> Self {
        let queryItems: [URLQueryItem] = [
            .init(name: "per_page", value: String(30)),
            .init(name: "page", value: String(page))
        ]
        
        return .init(
            path: "/users/\(loginName)/repos",
            method: .get,
            queryItems: queryItems
        )
    }
}
