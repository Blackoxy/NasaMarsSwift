//
//  Data.swift
//  ApiCalls
//
//  Created by Anh Nguyen on 3/11/20.
//  Copyright © 2020 Anh Nguyen. All rights reserved.
//

import Foundation
import UIKit

enum NasaError: Error {
    case noDataAvailable
    case cantProcessData
}
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


class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let request = NasaRequest()
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let photo = nasaData[indexPath.row].photos[indexPath.row]
        if let url = URL(string: photo.img_src) {
            URLSession.shared.downloadTask(with: request.resourceUrl){
                url, URLResponse, error in
                if let url = url {
                    if let string = try? String(contentsOf: url){
                        print(string)
                    }
                }
            }
        }
        return cell
    }
    
    public static func create() -> DataViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateInitialViewController() as! DataViewController
    }

    @IBOutlet weak var tableView: UITableView!
    
    var nasaData = [MarsPhotos]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dlJSON{_ in
            print("IDK")
        }
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func dlJSON(completion: @escaping (Result<[MarsPhotos], NasaError>) -> Void) {
        let request = NasaRequest()
        URLSession.shared.dataTask(with: request.resourceUrl) {(data, response, err) in
            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            //        let dataAsString = String(data: data, encoding: .utf8)
            //        print(dataAsString as Any)
            do {
                            let nasaDescription = try JSONDecoder().decode(MarsPhotos.self, from: data)
                            self.nasaData = [nasaDescription]
                completion(.success(self.nasaData))
                print(nasaDescription)
                
//                let courses =  try
//                    JSONDecoder().decode([Course].self, from: data)
//                DispatchQueue.main.async {
//                    completed()
//                }
//                print(courses)
                
                //            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                //            let course = Course(json: json)
                //            print(course.name)
                
                
            } catch let jsonErr{
                completion(.failure(.cantProcessData))
                print("Error serializing json:", jsonErr)
            }
            completion(.success(self.nasaData))

    }.resume()
}
}

//initializer isnt needed anymore. JSONDecoder() decodes by setting up all properties automatically based on what is inside JSON object
