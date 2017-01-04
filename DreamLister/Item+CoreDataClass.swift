//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by John Daratzikis on 11/12/2016.
//  Copyright © 2016 ioannisdaratzikis. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
