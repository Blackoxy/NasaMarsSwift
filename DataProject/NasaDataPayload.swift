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
    let API_KEY = "0SSNRR10zUmvE4dfJoRTz9tqCmZ4lfTvzBHkdj4e"
    
    init() {
        let earthDate = "2015-6-3"
        let resourceString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(earthDate)&api_key=\(API_KEY)"
        guard let resourceUrl = URL(string: resourceString) else {fatalError()}
        self.resourceUrl = resourceUrl
    }
}

enum NasaError: Error {
    case noDataAvailable
    case cantProcessData
}

public struct MarsPhotos: Decodable{
    let photos: [Photo]
}

public struct Photo: Decodable {
    let id: Int?
    let sol: Int?
    let camera: Camera
    let img_src: String
    let earth_date: String
    let rover: Rover
}

public struct Camera: Decodable {
    let id: Int?
    let name: String
    let rover_id: Int
    let full_name: String
}

public struct Rover: Decodable {
    let id: Int?
    let name: String
    let landing_date: String
    let launch_date: String
    let status: String
    let max_sol: Int
    let max_date: String
    let total_photos: Int
    let cameras: [RoverCameras]
}

public struct RoverCameras: Decodable {
    let name: String
    let full_name: String
}
