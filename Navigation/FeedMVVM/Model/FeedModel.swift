//
//  FeedModel.swift
//  Navigation
//
//  Created by Юлия Кагирова on 24.11.2023.
//

import UIKit

 final class FeedModel {
    
    //MARK: - Properties
    
    let secretWord: String = "Pass"
    
    //MARK: - Life Cycle
     
   
    
    //MARK: - Methods
    
    func check(word: String) -> Bool {
        if secretWord == word {
            return true
        }  else {
            return false
        }
    }
}
