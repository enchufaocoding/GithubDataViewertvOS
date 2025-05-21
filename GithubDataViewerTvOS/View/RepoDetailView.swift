//
//  RepoDetailView.swift
//  GithubDataViewerTvOS
//
//  Created by Jose Alberto Rosario Castillo on 16/5/25.
//

import SwiftUI

struct RepoDetailView: View {
    let repository: Repository
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                .padding(.leading, 40)
                .padding(.top, 20)
                
                Spacer()
            }
            RepositoryImageView(url: repository.owner.avatar_url)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(radius: 10)

            Text(repository.name)
                .font(.title)
                .bold()

            if let description = repository.description {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            if let language = repository.language {
                Text("Written in \(language)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Text("URL:")
                .font(.footnote)
                .foregroundColor(.gray)

            Text(repository.html_url)
                .font(.footnote)
                .foregroundColor(.blue)
                .lineLimit(1)
                .truncationMode(.middle)

            Spacer()
        }
        .padding()
        .navigationTitle("Repository User/owner Info")
        .onExitCommand(perform: {
            presentationMode.wrappedValue.dismiss()
        })
    }
}


