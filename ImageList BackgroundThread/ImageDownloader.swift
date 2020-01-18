//
//  ImageDownloader.swift
//  CodeCraftAssignment
//
//  Created by Asim Karel on 30/03/19.
//  Copyright © 2019 Asim. All rights reserved.
//

import Foundation
import UIKit
typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class NetworkManager {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    
    static var networkManager:NetworkManager!;
    
    static func sharedInstance() -> NetworkManager{
        if networkManager == nil{
            networkManager = NetworkManager();
        }
        return networkManager;
    }
    
    private init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    func getImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let url: URL! = URL(string: imagePath)
            session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage! = UIImage(data: data)
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            }).resume()
        }
    }
    
    func getData(route: String, completionHandler: @escaping (([CCImageModel]) -> ())) {
        let url: URL! = URL(string: getAuthorizedRoute(route: route))
        var images = [CCImageModel]()
        
        session.dataTask(with: url) { (data, response, error) in
            if error == nil{
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data!, options : .allowFragments) as? [Dictionary<String,Any>]
                    {
                        let dictArray = jsonArray as [NSDictionary];
                        for dict in dictArray{
                            images.append(CCImageModel(dict: dict));
                        }
                        completionHandler(images);
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            
            
            
        }.resume()
        
        
    }
    
    func getAuthorizedRoute(route:String) -> String {
        return "\(route)?client_id=808314846995df3e02828ee2e1585177de124b0b9d88bfdc4c9e5ac148473f85"
    }
    
    
}
