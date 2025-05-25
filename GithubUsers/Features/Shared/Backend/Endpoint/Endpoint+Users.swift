//
//  Endpoint+Users.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

extension Endpoint {
    ///
    /// Users
    ///
    /// - QueryItem:
    ///     - since: used for pagination
    ///
    /// - Important: HTTP Method Get
    ///
    static func users(since: Int) -> Self {
        let queryItems: [URLQueryItem] = [
            .init(name: "since", value: String(since))
        ]
        return .init(
            path: "/users",
            method: .get,
            queryItems: queryItems
        )
    }
    
    ///
    /// UsersDetails
    ///
    /// - Important: HTTP Method Get
    ///
    static func userDetails(loginName: String) -> Self {
        .init(
            path: "/users/\(loginName)",
            method: .get
        )
    }
}
