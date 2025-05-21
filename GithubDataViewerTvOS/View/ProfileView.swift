//
//  ProfileView.swift
//  GithubDataViewerTvOS
//
//  Created by Jose Alberto Rosario Castillo on 16/5/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = GitHubViewModel()
    let username: String
    let profileImageURL: String?
    let repositories: [Repository]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            profileImage
            usernameText
            repositoriesList
        }
    }
    
    @ViewBuilder
    private var profileImage: some View {
        if let urlString = profileImageURL, let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            .clipShape(Circle())
        }
    }
    
    private var usernameText: some View {
        Text(username)
            .font(.largeTitle)
            .padding(.bottom)
    }
    
    private var repositoriesList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(viewModel.userRepository) { repo in
                    repositoryRow(for: repo)
                }
            }
            .padding()
        }
        .frame(height: 400)
    }
    
    @ViewBuilder
    private func repositoryRow(for repository: Repository) -> some View {
        let avatar = RepositoryImageView(url: repository.owner.avatar_url)
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        
        let name = Text(repository.name)
            .font(.title3)
            .bold()
            .foregroundColor(.white)
        
        HStack(spacing: 15) {
            avatar
            name
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.6))
        .cornerRadius(20)
        .shadow(radius: 5)
        .transition(.scale.combined(with: .opacity))
        .animation(.easeInOut(duration: 0.4), value: viewModel.userRepository)
    }
}

