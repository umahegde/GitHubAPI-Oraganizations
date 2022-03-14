//
//  ViewModelProtocol.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 12/03/22.
//

import Foundation

// MARK: - Resource View Model Delegate
protocol OraganizationViewModelDelegate {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}
