//
//  Model.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 28.05.2024.
//

import Foundation

final class Model {
    
    //MARK: - Properties
    
    var path: String
    
    var title: String {
        return NSString(string: path).lastPathComponent
    }
    
    lazy var items: [String] = (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    
    //MARK: - Life Cycle
    
    init(path: String) {
        self.path = path
    }
    
    //MARK: - Methods
    
    func addFolder(title: String) {
        try? FileManager.default.createDirectory(atPath: path + "/" + title, withIntermediateDirectories: true)
        items = (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }
    
    func addImage(image: Data) {
        print(path)
        let url = URL(string: path)?.appendingPathComponent("image\(items.endIndex + 1).jpg")
        FileManager.default.createFile(atPath: (url?.path())!, contents: image)
        items = (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }
    
    func deleteItem(index: Int) {
        let pathForDelete = path + "/" + items[index]
        try? FileManager.default.removeItem(atPath: pathForDelete)
        items = (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
        
    }
    func isPathForItemIsFolder(index: Int) -> Bool {
        var objcBool: ObjCBool = .init(false)
        FileManager.default.fileExists(atPath: path + "/" + items[index], isDirectory: &objcBool)
        return objcBool.boolValue
    }
}
