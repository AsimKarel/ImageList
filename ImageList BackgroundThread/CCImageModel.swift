//
//  CCImageModel.swift
//  CodeCraftAssignment
//
//  Created by Asim Karel on 30/03/19.
//  Copyright © 2019 Asim. All rights reserved.
//

import Foundation
class CCImageModel{
    var id:String!;
    var url:String!;
    var description:String!;
    
    init(dict:NSDictionary) {
        if let id = (dict["id"] as? String) {
            self.id = id
        }
        if let urls = (dict["urls"] as? NSDictionary) {
            if let url = (urls["small"] as? String) {
                self.url = url;
            }
        }
        if let description = (dict["description"] as? String) {
            self.description = description
        }
    }
}
