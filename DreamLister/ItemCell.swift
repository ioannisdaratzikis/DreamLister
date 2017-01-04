//
//  ItemCell.swift
//  DreamLister
//
//  Created by John Daratzikis on 12/12/2016.
//  Copyright © 2016 ioannisdaratzikis. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var type: UILabel!
    
    func configureCell(item: Item){
    
        title.text = item.title
        price.text = String(item.price)
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
        type.text = item.toItemType?.type 
        
    }
    
}
