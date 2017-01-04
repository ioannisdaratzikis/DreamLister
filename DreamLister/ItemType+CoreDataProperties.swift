//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by John Daratzikis on 11/12/2016.
//  Copyright © 2016 ioannisdaratzikis. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
