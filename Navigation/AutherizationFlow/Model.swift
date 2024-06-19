//
//  Model.swift
//  Navigation
//
//  Created by Юлия Кагирова on 13.06.2024.
//

import UIKit
import RealmSwift


class AutherizationModel: Object {
    @Persisted var title: String = ""
    @Persisted var createdDate: Date = Date()
     
}

class Folder: Object {
    @Persisted var title: String = ""
    @Persisted var createdDate: Date = Date()
    @Persisted var items: List<Item>
}


class Item: Object {
    @Persisted var title: String = ""
    @Persisted var createdDate: Date = Date()
    @Persisted var imageData: Data?
     
}
