//
//  AutherizationManager.swift
//  Navigation
//
//  Created by Юлия Кагирова on 13.06.2024.
//

import UIKit
import RealmSwift

/* Установить REALM в ваше приложение.
 Создать модель авторизации.
 Добавить сохранение логина и пароля после ввода при помощи созданной модели.
 При повторном запуске приложения авторизация должна проходить автоматически, если ранее пользователь был авторизован.
 */


final class AutherizationManager {
    
}


final class FolderManager {
    
    
    var folders: [Folder] = []
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config
        self.folders = fetchFolders()
    }
    
    
    func addFolder(title: String) {
        let realm = try! Realm()
        let folder = Folder()
        folder.title = title + "\(folders.count)"
        folder.createdDate = Date()
        
        try! realm.write {
            realm.add(folder)
        }
        folders = fetchFolders()
    }
    
    func deleteFolder(at index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(folders[index])
        }
        folders = fetchFolders()
    }
    
    func renameFolder(newTitle: String, at index: Int) {
        let realm = try! Realm()
        try! realm.write {
            folders[index].title = newTitle
        }
        folders = fetchFolders()
    }
    
    func fetchFolders() -> [Folder] {
        let realm = try! Realm()
        
        return realm.objects(Folder.self).map { $0 }
    }
}
