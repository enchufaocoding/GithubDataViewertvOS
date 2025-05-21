//
//  HomeView.swift
//  GithubDataViewerTvOS
//
//  Created by Jose Alberto Rosario Castillo on 16/5/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GitHubViewModel()
    
    @State private var username: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Home Tv OS")
                    .font(.title2)

                TextField("Username", text: $username)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
                    .frame(width: 600)
                
                Button("Search") {
                    search()
                }
                .buttonStyle(.borderedProminent)
                .disabled(username.isEmpty)

                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(viewModel.userRepository) { repo in
                                NavigationLink(destination: RepoDetailView(repository: repo)) {
                                    HStack(spacing: 15) {
                                        RepositoryImageView(url: repo.owner.avatar_url)
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))

                                        Text(repo.name)
                                            .font(.title3)
                                            .bold()
                                            .foregroundColor(.white)

                                        Spacer()
                                    }
                                    .padding()
                                    .cornerRadius(20)
                                    .shadow(radius: 5)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                    .frame(height: 400)
                }
            }
            .padding()
        }
    }

    private func search() {
        viewModel.username = username
        viewModel.fetchGitHubUserInRepo()
    }
}
