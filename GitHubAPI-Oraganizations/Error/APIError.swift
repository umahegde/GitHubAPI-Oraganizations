//
//  APIError.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 12/03/22.
//

import Foundation

enum Result<Value: Decodable> {
    case success(Value)
    case failure(String)
}

