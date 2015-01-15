//
//  resultsCell.swift
//  ChatApp
//
//  Created by Allen Lee on 12/27/14.
//  Copyright (c) 2014 AllenLee. All rights reserved.
//

import UIKit

class resultsCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let theWidth = UIScreen.mainScreen().bounds.width
        
        contentView.frame = CGRectMake(0, 0, theWidth, 120)
        
        profileImg.center = CGPointMake(60, 60)
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        
        userNameLbl.center = CGPointMake(230, 55)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
