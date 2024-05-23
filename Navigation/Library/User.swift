//  User.swift
//  Navigation
//
//  Created by Юлия Кагирова on 17.11.2023.
//
import UIKit

public class Users {
     var login = String()
     var fullName = String()
     var status = String()
     var avatar = UIImage()
     var uid = String()
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
}
protocol UserService {
  func identification(login: String) -> Users?
}

class CurrentUserService: UserService {
    
    private init() {}
    static let shared = CurrentUserService()
    
    func identification(login: String) -> Users? {
        let userdebug = Users(login: "testRelease", fullName: "John", status: "fine", avatar: UIImage(named: "7")!)
        return userdebug
    }
}
class TestUserService: UserService {
    
    private init() {}
    static let shared = TestUserService()
    
    func identification(login: String) -> Users? {
        let userRelease = Users(login: "testDebug", fullName: "Chloe", status: "I am ok", avatar: UIImage(named: "2")!)
        return userRelease
    }
}
