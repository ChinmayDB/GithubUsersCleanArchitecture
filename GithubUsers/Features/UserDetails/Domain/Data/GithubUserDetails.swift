//
//  GithubUserDetails.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

struct GithubUserDetails: Decodable {
    let login: String
    let name: String?
    let avatarUrl: URL
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login, name, followers, following
        case avatarUrl = "avatar_url"
    }
}
