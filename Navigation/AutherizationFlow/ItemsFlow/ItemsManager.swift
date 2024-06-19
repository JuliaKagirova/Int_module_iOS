//
//  ItemsManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 19.06.2024.
//

import Foundation
import RealmSwift

final class ItemsManager {
    
    var items: [Item] = []
    var folder: Folder
    
    
    init(folder: Folder ) {
        self.folder = folder
        self.items = fetchItems()
    }
    
    func fetchItems() -> [Item] {
        folder.items.map { $0 }
        
    }
    
    func addItem(imageData: Data) {
        let realm = try! Realm()
        let item = Item()
        item.imageData = imageData
        item.createdDate = Date()
         
        try! realm.write {
            folder.items.append(item)
        }
        items = fetchItems()
    }
    
    func deleteItem(at index: Int) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(items[index])
        }
        items = fetchItems()
    }
}
