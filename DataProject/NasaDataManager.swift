//
//  NasaDataManager.swift
//  DataProject
//
//  Created by Anh Nguyen on 3/12/20.
//  Copyright © 2020 Anh Nguyen. All rights reserved.
//

import Foundation
import UIKit


public func downloadImage(completion: @escaping(_ image: UIImage?) -> Void) {
    let request = NasaRequest()
    let photoData = [MarsPhotos]()
    
    //wtf..
    if let url = URL(string: photoData[0].photos[0].img_src ) {
        URLSession.shared.downloadTask(with: request.resourceUrl){
            url, URLResponse, error in
            if let url = url {
                if let string = try? String(contentsOf: url){
                    print(string)
                }
            }
        }
    }
}
