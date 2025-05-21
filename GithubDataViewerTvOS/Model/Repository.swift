//
//  Repository.swift
//  GithubDataViewerTvOS
//
//  Created by Jose Alberto Rosario Castillo on 16/5/25.
//

import Foundation

struct Repository: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let html_url: String
    let owner: Owner
}

struct Owner: Codable, Equatable {
    let avatar_url: String
}




