//
//  Data.swift
//  ApiCalls
//
//  Created by Anh Nguyen on 3/11/20.
//  Copyright © 2020 Anh Nguyen. All rights reserved.
//

import Foundation
import UIKit

class DataViewController: UIViewController {
    
    
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
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                let nasaDescription = try JSONDecoder().decode(MarsPhotos.self, from: data)
                self.nasaData = [nasaDescription]
                completion(.success(self.nasaData))
                print(nasaDescription)
                
            } catch let jsonErr{
                completion(.failure(.cantProcessData))
                print("Error serializing json:", jsonErr)
            }
            completion(.success(self.nasaData))
            
        }.resume()
    }
    
    
}

extension DataViewController: UITableViewDelegate, UITableViewDataSource {
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
                        //wtf to all this..
                    }
                }
            }
            print(url)
        }
        return cell
    }
    
    func setCellImage(_ cell: NasaTableViewCell, forPayload payload: MarsPhotos ) {
//        wtf..
//        guard image != nil else { return }
//        cell.setProfilePicture(image, forPayload: payload)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
