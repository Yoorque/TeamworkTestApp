//
//  ProjectTableViewCell.swift
//  TeamworkTestApp
//
//  Created by Dusan Juranovic on 12/9/17.
//  Copyright © 2017 Dusan Juranovic. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var subStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
