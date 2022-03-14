//
//  ViewController.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 12/03/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  

    // MARK: - Private Variables
    private var viewModel: OrganizationViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = OrganizationViewModel(delegate: self)
        
        // Show a loading and fetch data
        self.startActivityIndicator()
        
        self.viewModel.fetchOrganizationList()

        self.initialSetup()
    
       
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // add navigation item title
        navigationItem.title =  "Organization List"
        
        
        
    }
    
    //MARK :Setup
    
    private func initialSetup() {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
             let titleAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)
             ]
             self.navigationController?.navigationBar.titleTextAttributes = titleAttributes

         } else {
              let titleAttributes = [
                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 27)
              ]
              self.navigationController?.navigationBar.titleTextAttributes = titleAttributes

         }

    }
    
    // MARKK: - Helpers
    private func startActivityIndicator() {
        
        self.view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailView" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let desVC = segue.destination as! OrganizationDetailViewController
                
                // pass selected resources to the next vc
                
                desVC.organizationList = viewModel.organization(at: indexPath.row)
               
            }
        }
    }
   
}



// MARK: - UITableView DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationCell", for: indexPath) as? OrganizationTableViewCell else {
            return OrganizationTableViewCell()
        }
        
        // Configure tableView cell
        cell.configureCell(with: viewModel.organization(at: indexPath.row))
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailView", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - OraganizationViewModel Delegate
extension ViewController: OraganizationViewModelDelegate {
    func onFetchCompleted() {
        print("Fetch completed..")
        self.stopActivityIndicator()
        self.view.bringSubviewToFront(tableView)
        tableView.reloadData()

    }

    func onFetchFailed(with reason: String) {
        self.stopActivityIndicator()
        
        let controller = UIAlertController(title: "An error occured", message: reason, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: {_ in
            exit(0)
        }))
        self.present(controller, animated: true, completion: nil)
        print(reason)
    }

}

