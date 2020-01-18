//
//  CCTableViewCell.swift
//  CodeCraftAssignment
//
//  Created by Asim Karel on 29/03/19.
//  Copyright © 2019 Asim. All rights reserved.
//

import UIKit

class CCTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(model:CCImageModel){
        self.icon.image = UIImage(named: "loading")
        NetworkManager.sharedInstance().getImageWithPath(imagePath: model.url) { (image) in
            self.icon.image = image
        }
    }
    
    
    

}
