//  FeedViewModel.swift
//  Navigation
//  Created by Юлия Кагирова on 04.12.2023.

import Foundation

protocol FeedViewModelProtocol: AnyObject {
    var stateChanger: ((FeedViewModel.State) -> Void)? { get set }
    func didTapCheckButton(text: String?)
}

final class FeedViewModel {
    enum State {
        case loading
        case success
        case error
    }
    
    //MARK: - Properties
    
    var stateChanger: ((State) -> Void)?
    let model: FeedModel
    private var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    //MARK: - Life Cycle
    
    init( model: FeedModel) {
        self.model = model
    }
    
    //MARK: - Methods
    
   private func checkPass(text: String?) {
        guard let pass = text, pass != "" else {
           print("empty")
           return
           }
       if model.check(word: pass) {
           print("OK")
           state = .success
       } else {
           print("Access is denied")
           state = .error
       }
   }
}

extension FeedViewModel: FeedViewModelProtocol {
    func didTapCheckButton(text: String?) {
        checkPass(text: text)
    }
}
