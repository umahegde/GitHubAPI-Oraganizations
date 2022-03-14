//
//  APIService.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 12/03/22.
//

import Foundation

class APIService:Requestable {
    

    static let sharedInstance = APIService()
    
    var session: URLSession = URLSession(configuration: .default)

    func fetchOrganizations(callback: @escaping Handler) {
        
        request(method: "GET", url: Domain.githubOrganizationURL) { (result) in
            
           callback(result)
        }
        
    }
    
}
