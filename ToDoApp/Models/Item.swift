//
//  Item.swift
//  ToDoApp
//
//  Created by Yashar Abbaslo on 1/23/1399 AP.
//  Copyright © 1399 Yashar Abbaslo. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // Relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
