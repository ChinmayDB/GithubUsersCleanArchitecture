//
//  GithubUsersApp.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import SwiftUI

@main
struct GithubUsersApp: App {
    var body: some Scene {
        WindowGroup {
            UsersView(viewModel: UsersViewModel())
        }
    }
}
