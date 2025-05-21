//
//  GitHubViewModel.swift
//  GithubDataViewerTvOS
//
//  Created by Jose Alberto Rosario Castillo on 16/5/25.
//


import Foundation

class GitHubViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var userRepository: [Repository] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    func fetchGitHubUserInRepo() {
        guard !username.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            InterfaceNetwork.getRepository(for: self.username) { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch result {
                    case .success(let repos):
                        self.userRepository = repos
                        if repos.isEmpty {
                            self.errorMessage = NetworkError.internetConnectionError.description
                        }
                    case .failure:
                        self.errorMessage = NetworkError.internetConnectionError.description
                    }
                }
            }
        }
    }
}

