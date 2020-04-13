//
//  Category.swift
//  ToDoApp
//
//  Created by Yashar Abbaslo on 1/23/1399 AP.
//  Copyright © 1399 Yashar Abbaslo. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var bgColor: String = ""
    
    // Relationship
    let items = List<Item>()
}
