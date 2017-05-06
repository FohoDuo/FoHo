//
//  Favorite+CoreDataProperties.swift
//  FoHo
//
//  Created by Brittney Ryn on 5/5/17.
//  Copyright © 2017 FohoDuo. All rights reserved.
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: String?
    @NSManaged public var recipeName: String?
    @NSManaged public var recipeImage: NSObject?
    @NSManaged public var webUrl: String?
    @NSManaged public var ingredients: NSArray?
    @NSManaged public var numServings: Int32
    @NSManaged public var totalTime: String?

}
