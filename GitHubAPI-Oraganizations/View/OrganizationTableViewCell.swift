//
//  OrganizationTableViewCell.swift
//  GitHubAPI-Oraganizations
//
//  Created by Uma Hegde on 13/03/22.
//

import UIKit

class OrganizationTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var organziationImageView: UIImageView!

    
    var buttonIndex:Int = 0
    var imageURL : String =  ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    @IBAction func imageButton(_ sender: Any) {
//        print(buttonIndex)
//        NotificationCenter.default.post(name: Notification.Name("imageview"), object: imageURL)
//
//    }
    
    // MARK: - Configure Cell
    public func configureCell(with organization: Organization) {
       
        label.text =  organization.login
        
        guard let url = organization.avatar_url else {
            return
        }
        organziationImageView?.loadImage(fromURL: url)
    
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
