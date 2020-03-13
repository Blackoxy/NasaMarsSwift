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
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBOutlet weak var nasaImage: UIImageView!
    @IBOutlet weak var solLabel: UILabel!
    @IBOutlet weak var earthDateLabel: UILabel!
    
    func bind(payload: Photo) {
        self.solLabel.text = "\(String(describing: payload.sol))"
        self.earthDateLabel.text = "\(String(describing: payload.earth_date))"
    }
    
    public func setProfilePicture(_ image: UIImage?, forPayload payload: Photo) {
        //        if let image = image {
        //            self.nasaImage.image = UIImage(named: )
        //        }
    }
}
