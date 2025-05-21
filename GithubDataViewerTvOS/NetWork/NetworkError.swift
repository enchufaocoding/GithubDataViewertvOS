//
//  NetworkError.swift
//  GithubDataViewerTvOS
//
//  Created by Jose Alberto Rosario Castillo on 20/5/25.
//


enum NetworkError: Error {
    case internetConnectionError
    case statusCodeError(Int)
    
    var description: String {
        switch self {
        case .internetConnectionError:
            return "A network error has occurred. Check your Internet connection and try again later."
        case .statusCodeError(let code):
            if code == 404 {
                return "User not found. Please enter another name"
            }
            return "An error occurred. Status code: \(code)"
        }
    }
}