//
//  UserDetailsView.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserDetailViewModel

    var body: some View {
        ScrollView {
            if let _ = viewModel.error {
                errorView()
            } else if let detail = viewModel.userDetail {
                VStack(spacing: 16) {
                    userDetailsView(for: detail)

                    Divider()

                    projectRepositoriesView()
                }.padding()
            } else if viewModel.isLoading {
                ProgressView("Loading...")
                    .accessibilityIdentifier("UserDetailLoadingIndicator")
            }
        }
        .task {
            await viewModel.load()
        }
        .navigationTitle("User Detail")
        .navigationBarTitleDisplayMode(.inline)
        .noInternetBanner(isVisible: viewModel.isNetworkConnectionLost)
    }
    
    private func errorView() -> some View {
        VStack(spacing: 16) {
            Text("Error: \(String(describing: viewModel.error))").foregroundColor(.red)
            Button("Try Again!") {
                Task {
                    viewModel.error = nil
                    await viewModel.load()
                }
            }
        }
    }
    
    private func userDetailsView(for userDetails: GithubUserDetails) -> some View {
        VStack(spacing: 16) {
            AsyncImage(url: userDetails.avatarUrl) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            
            Text(userDetails.login).font(.title)
            Text(userDetails.name ?? "").font(.headline)
            Text("Followers: \(userDetails.followers) | Following: \(userDetails.following)")
                .font(.subheadline)
        }
    }
    
    private func projectRepositoriesView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Repositories").font(.title2).bold()
            
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.projectRepositories, id: \.id) { repo in
                    repoLinkView(repo)
                }
                
                if viewModel.hasMoreProjectRepositories {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreProjectRepositories()
                            }
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private func repoLinkView(_ repo: GithubProjectRepository) -> some View {
        if let url = URL(string: repo.htmlUrl) {
            Link(destination: url) {
                repoRowView(repo)
            }
        } else {
            repoRowView(repo)
                .foregroundStyle(.gray)
                .disabled(true)
        }
    }
    
    private func repoRowView(_ repo: GithubProjectRepository) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(repo.name).font(.headline)
            if let description = repo.description {
                Text(description).font(.subheadline).foregroundColor(.secondary)
            }
            HStack {
                Text(repo.language ?? "Unknown").italic()
                Spacer()
                Image(systemName: "star.fill")
                Text("\(repo.stargazersCount)")
            }.font(.footnote)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
