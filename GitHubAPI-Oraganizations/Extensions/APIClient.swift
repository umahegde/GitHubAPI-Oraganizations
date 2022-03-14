//
//  APIClient.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 12/03/22.
//

import Foundation



typealias Handler = (Result<Data>) -> Void

protocol Requestable {}

extension Requestable {
  
    
    internal func request(method: String, url: String, params: [NSString: Any]? = nil, callback: @escaping Handler) {

        
        guard let url = URL(string: url) else {
            return
        }

        
        let task = URLSession.shared.dataTask(with: url,  completionHandler: { (data, response, error) in
         
        // let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    callback(.failure(error.localizedDescription))
                    
                } else if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        
                        let mappedModel = try? JSONDecoder().decode(Organizations.self, from: data!)
                        
                        if mappedModel != nil {
                            
                            callback(.success(data!))
                            
                        } else {
                            
                            callback(.failure("An error occurred while decoding data"))
                            
                        }
                    } else {
                        
                        callback(.failure("Response Unsuccessful"))
                    }
                }
            }
        })
        task.resume()
    }
}


