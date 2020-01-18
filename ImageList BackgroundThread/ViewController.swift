//
//  ViewController.swift
//  CodeCraftAssignment
//
//  Created by Asim Karel on 29/03/19.
//  Copyright © 2019 Asim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items = [CCImageModel]();
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! CCTableViewCell
        cell.setImage(model: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width-10;
    }
    
    func loadData(){
        loader.startAnimating()
        NetworkManager.sharedInstance().getData(route: "https://api.unsplash.com/photos/") { (images) in
            self.items = images;
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
}

