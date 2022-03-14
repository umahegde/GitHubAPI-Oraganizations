//
//  OrganizationViewModel.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 12/03/22.
//

import Foundation

class OrganizationViewModel {
    
    // MARK: - Private Variables
    private  var delegate: OraganizationViewModelDelegate?
    private var organizationList: [Organization] = []
    
    
    // MARK: - Public Varibles
    public var totalCount: Int {
        return organizationList.count
    }
    
    // MARK: - Initializer
    init(delegate: OraganizationViewModelDelegate) {
        self.delegate = delegate
    }
    
    
    // MARK: - Helprs
    func organization(at index: Int) -> Organization {
        return organizationList[index]
    }
  
    
    // MARK: - Network Call
    func fetchOrganizationList() {
        
        // Check for avoiding multiple network calls

        
        APIService.sharedInstance.fetchOrganizations{ result in
            
            switch result {
                
            case .success(let data):
                
                let mappedModel = try? JSONDecoder().decode(Organizations.self, from: data) as Organizations
                
                self.organizationList = mappedModel ?? []
                
                self.delegate?.onFetchCompleted()
                
                break
            case .failure(let error):
                self.delegate?.onFetchFailed(with: error)

                print(error.description)
            }
        }
     
    }


    


}
