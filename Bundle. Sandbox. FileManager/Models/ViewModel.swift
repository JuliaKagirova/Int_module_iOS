//
//  ViewModel.swift
//  Bundle. Sandbox. FileManager
//
//  Created by Юлия Кагирова on 04.06.2024.
//

import Foundation

final class ViewModel {
    
    private var store: KeychainServiceProtocol
    
    private(set) var settings: [KeychainService]
    
    init(store: KeychainServiceProtocol) {
        self.store = store
        self.settings = store.load()
    }
    
    func addItem(title: String) {
        settings.append( KeychainService(title: title))
        store.save(items: settings)
    }
    
    func deleteItem(at index: Int) {
        settings.remove(at: index)
        store.save(items: settings)
    }
    
    func toggleItem(at index: Int) {
        settings[index].isCompleted.toggle()
        store.save(items: settings)
    }
    
    func renameItem(at index: Int, newtitle: String) {
        settings[index].title = newtitle
        store.save(items: settings )
    }
    func setStore(store: KeychainServiceProtocol) {
        self.store = store
        settings = store.load()
    }
}
