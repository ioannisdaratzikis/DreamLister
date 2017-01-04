//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by John Daratzikis on 31/12/2016.
//  Copyright © 2016 ioannisdaratzikis. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var thumImage: UIImageView!
    @IBOutlet weak var typeField: UITextField!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let topItem = self.navigationController?.navigationBar.topItem {
        
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        /*let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        let store3 = Store(context: context)
        store3.name = "Frys Electronics"
        let store4 = Store(context: context)
        store4.name = "Target"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "K Mart"
        
        ad.saveContext()*/
        
        getStores()
        
        if itemToEdit != nil {
        
            loadItemData()
            
        }
        
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        }catch{
            
            let error = error as NSError
            print("\(error)")
            
        }

    
    }
    
    @IBAction func saveItem(_ sender: Any) {
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumImage.image
        
        let type = ItemType(context: context)
        type.type = typeField.text
        
        
        if itemToEdit == nil {
        
            item = Item(context: context)
        
        }else {
        
            item  = itemToEdit
        
        }
        
        if let title = titleField.text {
            
            item.title = title
            
        }
        
        if let price = priceField.text {
            
            item.price = Double(price)!
            
        }
        
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        item.toImage = picture
        
        item.toItemType = type
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    func loadItemData () {
        
        if let item = itemToEdit {
        
            titleField.text = item.title
            priceField.text = String(describing: item.price)
            detailsField.text = item.details
            
            thumImage.image = item.toImage?.image as? UIImage
            
            typeField.text = item.toItemType?.type
            
            
            if let store = item.toStore {
                
                var index = 0
                repeat{
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                        
                    }
                    
                    index += 1
                    
                }while (index < stores.count)
                
            }
        
        }
    
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        
        if itemToEdit != nil {
            
            context.delete(itemToEdit!)
            ad.saveContext()
            
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func pickImage(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
            thumImage.image = image
        
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
