//
//  Organization.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 12/03/22.
//

import Foundation


typealias Organizations = [Organization]

struct Organization : Codable {
    let login : String?
    let id : Int?
    let node_id : String?
    let url :String?
    let repos_url : String?
    let events_url : String?
    let hooks_url : String?
    let issues_url : String?
    let members_url : String?
    let public_members_url : String?
    let avatar_url : String?
    let description : String?
  
    enum CodingKeys: String, CodingKey {
        
        case login = "login"
        case id = "id"
        case node_id = "node_id"
        case url = "url"
        case repos_url = "repos_url"
        case events_url = "events_url"
        case hooks_url = "hooks_url"
        case issues_url = "issues_url"
        case members_url = "members_url"
        case public_members_url = "public_members_url"
        case avatar_url = "avatar_url"
        case description = "description"
    
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        node_id = try values.decodeIfPresent(String.self, forKey: .node_id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        repos_url = try values.decodeIfPresent(String.self, forKey: .repos_url)
        events_url = try values.decodeIfPresent(String.self, forKey: .events_url)
        hooks_url = try values.decodeIfPresent(String.self, forKey: .hooks_url)
        issues_url = try values.decodeIfPresent(String.self, forKey: .issues_url)
        members_url = try values.decodeIfPresent(String.self, forKey: .members_url)
        public_members_url = try values.decodeIfPresent(String.self, forKey: .public_members_url)
        avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        
    }
    
}
