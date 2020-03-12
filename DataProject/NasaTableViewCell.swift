//
//  NasaTableViewCell.swift
//  DataProject
//
//  Created by Anh Nguyen on 3/11/20.
//  Copyright © 2020 Anh Nguyen. All rights reserved.
//

import UIKit

class NasaTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NasaTableViewCell"
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var nasaImage: UIImageView!
    @IBOutlet weak var solLabel: UILabel!
    @IBOutlet weak var earthDateLabel: UILabel!
    
    public func setProfilePicture(_ image: UIImage?, forPayload payload: Photo) {

    }
}
