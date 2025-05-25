//
//  GithubProjectRepository.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

struct GithubProjectRepository: Decodable, Equatable {
    let id: Int
    let name: String
    let language: String?
    let stargazersCount: Int
    let description: String?
    let isFork: Bool
    let htmlUrl: String
    let hasPages: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, language, description, isFork = "fork", stargazersCount = "stargazers_count", htmlUrl = "html_url", hasPages = "has_pages"
    }
}
