//
//  GithubUser.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

struct GithubUser: Codable, Identifiable, Equatable {
    let id: Int
    let login: String
    let avatar_url: String
}
