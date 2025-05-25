//
//  Endpoint.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import Foundation

struct Endpoint {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]
    let headers: [String: String]
    let body: [String: Any]?

    var url: URL {
        var components = URLComponents(string: "https://api.github.com")!
        components.path += path
        components.queryItems = queryItems
        return components.url!
    }
    
    init(path: String,
         method: HTTPMethod = .get,
         queryItems: [URLQueryItem] = [],
         headers: [String: String] = [:],
         body: [String: Any]? = nil) {
        
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
