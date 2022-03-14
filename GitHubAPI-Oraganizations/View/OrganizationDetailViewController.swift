//
//  OrganizationDetailViewController.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 13/03/22.
//

import UIKit

class OrganizationDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var repos_url: UILabel!
    @IBOutlet weak var events_url: UILabel!
    @IBOutlet weak var issues_url: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var hooks_url: UILabel!
 
    
    var organizationList: Organization?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.displayData()
        
    }
    
    
    // MARK: - Display Data
    public func displayData() {
        
        if let organization = organizationList {
            
            login.text = "Login : " + (organization.login ?? " ")
            url.text = "URL : " + (organization.url ?? " " )
            repos_url.text = "Repos_URL : " + (organization.repos_url ?? " ")
            events_url.text = "Events_URL : " + (organization.events_url ?? " ")
            issues_url.text = "Issues_URL : " + (organization.issues_url ?? " ")
            desc.text = "Description :" + (organization.description ?? " ")
            hooks_url.text = "Hooks_URL : " + (organization.hooks_url ?? " ")
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
