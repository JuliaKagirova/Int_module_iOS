//
//  User.swift
//  Navigation
//
//  Created by Юлия Кагирова on 07.05.2023.
//

import UIKit
 
public class User {
     var login = String()
     var fullName = String()
     var status = String()
     var avatar = UIImage()
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
}
protocol UserService {
  static func identification(login: String) -> User?
}
class CurrentUserService: UserService {
    static func identification(login: String) -> User? {
        let userdebug = User(login: "testDebug", fullName: "John", status: "fine", avatar: UIImage(named: "7")!)
        return userdebug
    }
}
class TestUserService: UserService {
    static func identification(login: String) -> User? {
        let userRelease = User(login: "testRelease", fullName: "Chloe", status: "I am ok", avatar: UIImage(named: "2")!)
        return userRelease
    }
}

//protocol UserService {
//  static func identification(user: User) -> User?
//}
//
//class CurrentUserService: UserService {
//    static func identification(user: User) -> User? {
//        let savedUser = User(login: "release", fullName: "test release", status: "fine", avatar: UIImage(named: "2")!)
//        return savedUser
//    }
//}
//
//class TestUserService: UserService {
//    static func identification(user: User) -> User? {
//      let savedUser = User(login: "debug", fullName: "test debug", status: "ok", avatar: UIImage(named: "1")!)
//        return savedUser
//    }
//}
