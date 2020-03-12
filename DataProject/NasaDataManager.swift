//
//  NasaDataManager.swift
//  DataProject
//
//  Created by Anh Nguyen on 3/12/20.
//  Copyright © 2020 Anh Nguyen. All rights reserved.
//

import Foundation

struct NasaRequest {
    let resourceUrl: URL
    let API_KEY = "W02q5h7TG6f54N0P39quJ0zh0pZ8YdcGqIVwvPIy"
    
    init() {
        let earthDate = "2015-6-3"
        let resourceString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(earthDate)&api_key=\(API_KEY))"
        guard let resourceUrl = URL(string: resourceString) else {fatalError()}
        self.resourceUrl = resourceUrl
    }
}

