//
//  Item+CoreDataProperties.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var category: Category?

}

extension Item : Identifiable {

}
