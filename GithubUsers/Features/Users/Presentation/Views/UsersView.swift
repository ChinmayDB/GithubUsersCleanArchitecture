//
//  UsersView.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import SwiftUI

struct UsersView: View {
    
    @StateObject private var viewModel: UsersViewModel
    @State private var showAlert = false
    @State private var navigationPath = NavigationPath()
    
    init(viewModel: UsersViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            if let _ = viewModel.error {
                errorView()
            } else {
                List(viewModel.users, id: \.id) { user in
                    singleUserView(for : user)
                        .accessibilityIdentifier("UserCell_\(user.login)")
                        .onTapGesture {
                            navigationPath.append(AppRoute.userDetails(loginName: user.login))
                        }
                }
                .navigationTitle("GitHub Users")
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .userDetails(let loginName):
                        UserDetailsView(
                            viewModel: UserDetailViewModel(
                                login: loginName,
                                getOwnProjectRepositoriesUseCase: GetOwnProjectRepositoriesUseCase(
                                    projectRepository: Repository.shared.projectRepository,
                                    loginName: loginName
                                )
                            )
                        )
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                        .accessibilityIdentifier("UsersLoadingIndicator")
                }
            }
        }
        .task {
            await viewModel.load()
        }
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
    
    private func singleUserView(for user: GithubUser) -> some View {
        HStack {
            AsyncImage(url: URL(string: user.avatar_url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            Text(user.login)
                .font(.headline)
        }
        .onAppear {
            if user.id == viewModel.users.last?.id {
                Task {
                    await viewModel.load()
                }
            }
        }
    }
}
